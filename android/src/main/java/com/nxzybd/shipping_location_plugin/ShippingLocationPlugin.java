package com.nxzybd.shipping_location_plugin;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.hdgq.locationlib.LocationOpenApi;
import com.hdgq.locationlib.keeplive.KeepLive;
import com.hdgq.locationlib.keeplive.config.ForegroundNotification;
import com.hdgq.locationlib.keeplive.config.ForegroundNotificationClickListener;
import com.hdgq.locationlib.keeplive.config.KeepLiveService;
import com.hdgq.locationlib.listener.OnResultListener;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ShippingLocationPlugin
 */
public class ShippingLocationPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Activity activity;
    private Context application;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "shipping_location_plugin");
        channel.setMethodCallHandler(this);
        application = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("init")) {
            //进程保活
            //定义前台服务的默认样式。即标题、描述和图标
            ForegroundNotification foregroundNotification = new
                    ForegroundNotification("中运宝", "车主端", R.mipmap.ic_launcher,
                    //定义前台服务的通知点击事件
                    new ForegroundNotificationClickListener() {
                        @Override
                        public void foregroundNotificationClick(Context context, Intent intent) {
                            Log.e("apicloud", "app foregroundNotificationClick");
                        }
                    });
            //启动保活服务，没有报错但是没起作用
            KeepLive.startWork((Application) application, KeepLive.RunMode.ENERGY,
                    foregroundNotification,
//你需要保活的服务，如 socket 连接、定时任务等，建议不用匿名内部类的方式在这里写
                    new KeepLiveService() {
                        /**
                         * 运行中
                         * 由于服务可能会多次自动启动，该方法可能重复调用
                         */
                        @Override
                        public void onWorking() {
                            Log.e("apicloud", "app onWorking");
                        }

                        /**
                         * 服务终止
                         * 由于服务可能会被多次终止，该方法可能重复调用，需同 onWorking 配
                         套使用，
                         * 如注册和注销 broadcast
                         */
                        @Override
                        public void onStop() {
                            Log.e("apicloud", "app onStop");
                        }
                    }
            );
            Log.e("apicloud", "KeepLive");
            String appId = call.argument("appId");
            String appSecurity = call.argument("appSecurity");
            String enterpriseSenderCode = call.argument("enterpriseSenderCode");
            String environment = call.argument("environment");

            LocationOpenApi.init(activity, appId, appSecurity, enterpriseSenderCode, environment, new OnResultListener() {
                @Override
                public void onSuccess() {
                    Log.e("apicloud", "onSuccess");
                }

                @Override
                public void onFailure(String s, String s1) {
                    Log.e("apicloud", s + ": " + s1);
                }
            });

            result.success("init: \n" + appId + "\n," + appSecurity + "\n," + enterpriseSenderCode + "\n," + environment);
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

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();

    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
