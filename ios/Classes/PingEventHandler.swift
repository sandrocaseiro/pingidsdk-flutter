//
//  PingEventHandler.swift
//  pingidsdk
//
//  Created by Sandro Caseiro on 6/18/20.
//

import Foundation
import PingID_SDK

public class PingEventHandler : NSObject, PingIDDelegate {
    let channel: FlutterMethodChannel
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public func handleCallback(_ state: PIDFlowState, _ x: Any?, _ error: Error?) {
        switch state {
        case PIDFlowState.trustLevels:
            onPairingOptionsRequired(availableTrustLevels: x as! [UInt])
        default:
            break
        }
    }
    
    public func handleRemoteNotification(_ notificationType: PIDRemoteNotificationType, _ availableTrustLevels: [Any]?,
                                         _ sessionInfo: [AnyHashable : Any]?, _ error: Error?) {
        let info = sessionInfo as? [String: AnyObject]
        switch notificationType {
        case PIDRemoteNotificationType.auth:
            onAuthenticationRequired(info)
        case PIDRemoteNotificationType.done:
            onAuthenticationCompleted(error as NSError?)
        default:
            break
        }
    }
    
    public func onPairingOptionsRequired(availableTrustLevels: [UInt], deviceName: String? = nil) {
        let args: [String: Any?] = [
            PairingOptionsRequiredArgs.AVAILABLE_TRUST_LEVELS.rawValue: availableTrustLevels.map({ (t: UInt) -> String in
                return PIDTrustLevel(rawValue: t)!.stringValue
            }),
            PairingOptionsRequiredArgs.DEVICE_NAME.rawValue: deviceName
        ]
        
        channel.invokeMethod(FlutterMethods.PAIRING_OPTIONS_REQUIRED.rawValue, arguments: args)
    }
    
    public func onPairingCompleted(_ error: NSError?) {
        var errorMessage: String? = nil
        if (error?.domain == "PIDErrorDomain") {
            errorMessage = PIDError(rawValue: UInt(bitPattern: error!.code))?.description
        }

        let args: [String: Any?] = [
            PairingCompletedArgs.ACTION_STATUS.rawValue: error == nil ? PIDActionStatusValues.SUCCESS.rawValue : PIDActionStatusValues.FAILURE.rawValue,
            PairingCompletedArgs.ERROR.rawValue: errorMessage
        ]
        channel.invokeMethod(FlutterMethods.PAIRING_COMPLETED.rawValue, arguments: args)
    }
    
    public func didUntrustDevice() {
        channel.invokeMethod(FlutterMethods.DID_UNTRUST_DEVICE.rawValue, arguments: nil)
    }
    
    public func onAuthenticationRequired(_ data: [String: AnyObject]?) {
        let args: [String: Any?] = [
            AuthenticationRequiredArgs.DATA.rawValue: data
        ]
        channel.invokeMethod(FlutterMethods.AUTHENTICATION_REQUIRED.rawValue, arguments: args)
    }
    
    public func onAuthenticationCompleted(_ error: NSError?) {
        var errorMessage: String? = nil
        if (error?.domain == "PIDErrorDomain") {
            errorMessage = PIDError(rawValue: UInt(bitPattern: error!.code))?.description
        }
        
        let args: [String: Any?] = [
            AuthenticationCompletedArgs.ACTION_STATUS.rawValue: error == nil ? PIDActionStatusValues.SUCCESS.rawValue : PIDActionStatusValues.FAILURE.rawValue,
            AuthenticationCompletedArgs.ACTION.rawValue: error == nil ? PIDActionTypeValues.PIDActionTypeApprove.rawValue : PIDActionTypeValues.PIDActionTypeNone.rawValue,
            AuthenticationCompletedArgs.ERROR.rawValue: errorMessage
        ]
        channel.invokeMethod(FlutterMethods.AUTHENTICATION_COMPLETED.rawValue, arguments: args)
    }
    
    public func onAuthenticationCancelled() {
        channel.invokeMethod(FlutterMethods.AUTHENTICATION_CANCELLED.rawValue, arguments: nil)
    }
    
    public func didRefreshOneTimePasscode(_ oneTimePasscode: String) {
        let args: [String: Any?] = [
            OneTimePasswordChangedArgs.OTP.rawValue: oneTimePasscode
        ]
        channel.invokeMethod(FlutterMethods.ONE_TIME_PASSWORD_CHANGED.rawValue, arguments: args)
    }

    public func authenticationTokenStatus(_ sessionInfo: [AnyHashable : Any], error: Error?) {
        let args: [String: Any?] = [
            AuthenticationTokenStatusArgs.DATA.rawValue: sessionInfo,
            AuthenticationTokenStatusArgs.ERROR.rawValue: (error as NSError?)?.localizedDescription
        ]
        channel.invokeMethod(FlutterMethods.AUTHENTICATION_TOKEN_STATUS.rawValue, arguments: args)
    }
}
