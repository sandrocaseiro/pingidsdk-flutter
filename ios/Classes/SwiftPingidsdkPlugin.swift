import Flutter
import UIKit
import PingID_SDK

public class SwiftPingidsdkPlugin: NSObject, FlutterPlugin, UNUserNotificationCenterDelegate {
    private let eventHandler: PingEventHandler;
    
    init(_ eventHandler: PingEventHandler) {
        self.eventHandler = eventHandler
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "pingidsdk", binaryMessenger: registrar.messenger())
        
        let eventHandler = PingEventHandler(channel: channel)
        let instance = SwiftPingidsdkPlugin(eventHandler)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
        
        if let path = Bundle.main.path(forResource: "Ping", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let pref = try? PropertyListDecoder().decode(PingProperties.self, from: xml) {
            PingID.initWithAppID(pref.APPLICATION_ID, supportedMfa: PIDSupportedMfaType.automatic)
            PingID.setDebugMode(pref.DEBUG_CERTIFICATE)
            PingID.setPingIDDelegate(eventHandler)
        }
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if granted {
                    // Registering UNNotificationCategory more than once results in previous categories being overwritten. PingID provides the needed categories. The developer may add categories.
                    UNUserNotificationCenter.current().setNotificationCategories(PingID.getRemoteNotificationsCategories() as! Set<UNNotificationCategory>)
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
        else {
            let categories = PingID.getDeprecatedRemoteNotificationsCategories()
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: categories as? Set<UIUserNotificationCategory>)

            DispatchQueue.main.async {
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        return true
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PingID.setRemoteNotificationsDeviceToken(deviceToken)
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                            fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        if (PingID.isRemoteNotification(fromPingID: userInfo)) {
            PingID.handleRemoteNotification(userInfo) { (notificationType: PIDRemoteNotificationType, availableTrustLevels: [Any]?,
                sessionInfo: [AnyHashable : Any]?, error: Error?) in
                self.eventHandler.handleRemoteNotification(notificationType, availableTrustLevels, sessionInfo, error)
            }
            return true
        }
        
        return false
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case PingEvents.GET_PAYLOAD.rawValue:
            let payload = handleGetPayload()
            result(payload ?? FlutterError())
        case PingEvents.SERVER_PAYLOAD.rawValue:
            handleServerPayload(call)
            result(nil)
        case PingEvents.PAIRING_SELECTION.rawValue:
            handlePairingSelection(call)
            result(nil)
        case PingEvents.AUTHENTICATION_SELECTION.rawValue:
            handleAuthenticationSelection(call)
            result(nil)
        case PingEvents.DEVICE_IS_TRUSTED.rawValue:
            result(handleDeviceIsTrusted())
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    func handleGetPayload() -> String? {
        do {
            return try PingID.generatePayload()
        }
        catch {
            return nil
        }
    }
    
    func handleServerPayload(_ call: FlutterMethodCall) {
        let args = call.arguments as! [String: Any]
        PingID.setServerPayload(args[ServerPayloadArgs.PAYLOAD.rawValue] as! String, completionBlock: {
            (_ state: PIDFlowState, _ x: Any?, _ error: Error?) in
            self.eventHandler.handleCallback(state, x, error)
        })
    }
    
    func handlePairingSelection(_ call: FlutterMethodCall) {
        let args = call.arguments as! [String: Any]
        
        let u = PIDUserSelectionObject(action: (args[PairingSelectionArgs.ACTION.rawValue] as! String).asPIDActionType,
                                       trustLevel: (args[PairingSelectionArgs.TRUST_LEVEL.rawValue] as! String).asPIDTrustLevel,
                                       userName: args[PairingSelectionArgs.USERNAME.rawValue] as? String)
        
        PingID.setUserSelection(u) { (err: Error?) in
            self.eventHandler.onPairingCompleted(err as NSError?)
        }
    }
    
    func handleAuthenticationSelection(_ call: FlutterMethodCall) {
        let args = call.arguments as! [String: Any]
        
        let u = PIDUserSelectionObject(action: (args[AuthenticationSelectionArgs.ACTION.rawValue] as! String).asPIDActionType,
                                       trustLevel: PIDTrustLevel.none,
                                       userName: args[AuthenticationSelectionArgs.USERNAME.rawValue] as? String)

        PingID.setAuthenticationUserSelection(u)  { (err: Error?) in
            self.eventHandler.onAuthenticationCompleted(err as NSError?)
        }
    }
    
    func handleDeviceIsTrusted() -> Bool {
        return PingID.isDeviceTrusted()
    }
}
