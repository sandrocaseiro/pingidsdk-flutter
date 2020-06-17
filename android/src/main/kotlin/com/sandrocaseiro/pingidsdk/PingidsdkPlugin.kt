package com.sandrocaseiro.pingidsdk

import android.app.Application
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull;
import com.google.firebase.FirebaseApp
import com.sandrocaseiro.pingidsdk.extensions.toPIDActionType
import com.sandrocaseiro.pingidsdk.extensions.toPIDTrustLevel

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import pingidsdkclient.PIDUserSelectionObject
import pingidsdkclient.PingID

/** PingidsdkPlugin */
public class PingidsdkPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "pingidsdk")
        channel.setMethodCallHandler(this);

        initPing(flutterPluginBinding.applicationContext, channel)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "pingidsdk")
            channel.setMethodCallHandler(PingidsdkPlugin())

            initPing(registrar.activeContext(), channel)
        }

        private fun initPing(context: Context, channel: MethodChannel) {
            PingID.init(context as Application, BuildConfig.PING_APPLICATION_ID, PingEventHandler(channel), BuildConfig.PING_PUSH_SENDER_ID,
                PingID.PIDSupportedMfaType.PIDSupportedMfaTypeAutomatic)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            PingEvents.GET_PAYLOAD -> {
                handleGetPayload {
                    result.success(it)
                }
            }
            PingEvents.SERVER_PAYLOAD -> {
                handleServerPayload(call)
                result.success(null)
            }
            PingEvents.PAIRING_SELECTION -> {
                handlePairingSelection(call)
                result.success(null)
            }
            PingEvents.AUTHENTICATION_SELECTION -> {
                handleAuthenticationSelection(call)
                result.success(null)
            }
            PingEvents.DEVICE_IS_TRUSTED -> result.success(handleDeviceIsTrusted())
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun handleGetPayload(callback: (String) -> Unit) {
        PingID.getInstance().generatePayload(callback)
    }

    private fun handleServerPayload(call: MethodCall) {
        PingID.getInstance().setServerPayload(call.argument(ServerPayloadArgs.PAYLOAD))
    }

    private fun handlePairingSelection(call: MethodCall) {
        val u = PIDUserSelectionObject().apply {
            this.pidTrustLevel = call.argument<String>(PairingSelectionArgs.TRUST_LEVEL)!!.toPIDTrustLevel()
            this.pidActionType = call.argument<String>(PairingSelectionArgs.ACTION)!!.toPIDActionType()
            this.pidUsername = call.argument(PairingSelectionArgs.USERNAME)
        }
        PingID.getInstance().setUserSelection(u)
    }

    private fun handleAuthenticationSelection(call: MethodCall) {
        val u = PIDUserSelectionObject().apply {
            this.pidActionType = call.argument<String>(AuthenticationSelectionArgs.ACTION)!!.toPIDActionType()
            this.pidUsername = call.argument(AuthenticationSelectionArgs.USERNAME)
        }
        PingID.getInstance().setAuthenticationUserSelection(u)
    }

    private fun handleDeviceIsTrusted(): Boolean = PingID.getInstance().isDeviceTrusted;
}
