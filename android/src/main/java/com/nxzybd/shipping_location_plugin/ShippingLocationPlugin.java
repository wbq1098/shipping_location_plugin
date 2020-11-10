package com.nxzybd.shipping_location_plugin;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.hdgq.locationlib.LocationOpenApi;
import com.hdgq.locationlib.listener.OnResultListener;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ShippingLocationPlugin
 */
public class ShippingLocationPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "shipping_location_plugin");
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("init")) {
            String appId = call.argument("appId");
            String appSecurity = call.argument("appSecurity");
            String enterpriseSenderCode = call.argument("enterpriseSenderCode");
            String environment = call.argument("environment");
            result.success("init: \n" + appId + "\n," + appSecurity + "\n," + enterpriseSenderCode + "\n," + environment);
            LocationOpenApi.init(context, appId, appSecurity, enterpriseSenderCode, environment, new OnResultListener() {
                @Override
                public void onSuccess() {
                    Log.i("shipping_location", "onSuccess");
                }

                @Override
                public void onFailure(String s, String s1) {
                    Log.i("shipping_location", s + ": " + s1);
                }
            });
        } else if (call.method.equals("start")) {
            result.success("start");
        } else if (call.method.equals("stop")) {
            result.success("stop");
        } else {
            result.notImplemented();
//            result.error("404", "未匹配到对应的方法"+call.method, null);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
