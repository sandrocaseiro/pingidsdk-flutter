package com.sandrocaseiro.pingidsdk

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.sandrocaseiro.pingidsdk.extensions.toMap
import io.flutter.plugin.common.MethodChannel
import pingidsdkclient.DeviceDetails
import pingidsdkclient.PingID

class PingEventHandler(private val channel: MethodChannel) : PingID.PingIdSdkEvents {
    private val mainHandler = Handler(Looper.getMainLooper())

    //Pairing Events
    override fun onPairingOptionsRequired(availableTrustLevels: MutableList<String>?, deviceDetails: DeviceDetails?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.PAIRING_OPTIONS_REQUIRED, mapOf(
                PairingOptionsRequiredArgs.AVAILABLE_TRUST_LEVELS to availableTrustLevels,
                PairingOptionsRequiredArgs.DEVICE_NAME to deviceDetails?.name
            ))
        }
    }

    override fun onPairingOptionsRequiredWithPasscode(
        availableTrustLevels: MutableList<String>?,
        deviceName: String?
    ) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.PAIRING_OPTIONS_REQUIRED_WITH_PASSWORD, mapOf(
                PairingOptionsRequiredWithPasswordArgs.AVAILABLE_TRUST_LEVELS to availableTrustLevels,
                PairingOptionsRequiredWithPasswordArgs.DEVICE_NAME to deviceName
            ))
        }
    }

    override fun onPairingProgress(msg: String?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.PAIRING_PROGRESS, mapOf(
                PairingProgressArgs.MESSAGE to msg
            ))
        }
    }

    override fun onPairingCompleted(
        status: PingID.PIDActionStatus?,
        error: PingID.PIDErrorDomain?
    ) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.PAIRING_COMPLETED, mapOf(
                PairingCompletedArgs.ACTION_STATUS to status.toString(),
                PairingCompletedArgs.ERROR to error.toString()
            ))
        }
    }

    override fun onIgnoreDeviceCompleted(
        status: PingID.PIDActionStatus?,
        error: PingID.PIDErrorDomain?
    ) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.IGNORE_DEVICE_COMPLETED, mapOf(
                IgnoreDeviceCompletedArgs.ACTION_STATUS to status.toString(),
                IgnoreDeviceCompletedArgs.ERROR to error.toString()
            ))
        }
    }

    override fun didUntrustDevice() {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.DID_UNTRUST_DEVICE, null)
        }
    }

    //Authentication Events
    override fun onAuthenticationRequired(data: Bundle?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.AUTHENTICATION_REQUIRED, mapOf(
                AuthenticationRequiredArgs.DATA to data?.toMap()
            ))
        }

    }

    override fun onAuthenticationCompleted(
        status: PingID.PIDActionStatus?,
        action: PingID.PIDActionType?,
        error: PingID.PIDErrorDomain?
    ) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.AUTHENTICATION_COMPLETED, mapOf(
                AuthenticationCompletedArgs.ACTION_STATUS to status.toString(),
                AuthenticationCompletedArgs.ACTION to action.toString(),
                AuthenticationCompletedArgs.ERROR to error.toString()
            ))
        }
    }

    override fun onAuthenticationCancelled() {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.AUTHENTICATION_CANCELLED, null)
        }
    }

    override fun onOneTimePasscodeChanged(newOneTimePasscode: String?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.ONE_TIME_PASSWORD_CHANGED, mapOf(
                OneTimePasswordChangedArgs.OTP to newOneTimePasscode
            ))
        }
    }

    override fun authenticationTokenStatus(data: Bundle?, error: PingID.PIDErrorDomain?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.AUTHENTICATION_TOKEN_STATUS, mapOf(
                AuthenticationTokenStatusArgs.DATA to data?.toMap(),
                AuthenticationTokenStatusArgs.ERROR to error.toString()
            ))
        }
    }

    //General Events
    override fun onServicePayloadReceivedWithStatusDone() {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.SERVICE_PAYLOAD_RECEIVED_WITH_STATUS_DONE, null)
        }
    }

    override fun onLogsSentToServer(status: PingID.PIDActionStatus?, supportId: String?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.LOGS_SENT_TO_SERVER, mapOf(
                LogsSentToServerArgs.ACTION_STATUS to status.toString(),
                LogsSentToServerArgs.SUPPORT_ID to supportId
            ))
        }
    }

    override fun onGeneralMessage(msg: String?) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.GENERAL_MESSAGE, mapOf(
                GeneralMessageArgs.MESSAGE to msg
            ))
        }
    }

    override fun onGooglePlayServicesStatusReceived(status: Int) {
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.GOOGLE_PLAY_SERVICES_STATUS_RECEIVED, mapOf(
                GooglePlayServicesStatusReceivedArgs.STATUS to status
            ))
        }
    }

    override fun onError(throwable: Throwable?, description: String?) {
        Log.d("PingEvent", "onError: Throwable: $throwable | $description")
        mainHandler.post {
            channel.invokeMethod(FlutterMethods.ERROR, mapOf(
                ErrorArgs.THROWABLE to throwable,
                ErrorArgs.DESCRIPTION to description
            ))
        }
    }
}