import 'dart:async';

import 'package:flutter/services.dart';

class ShippingLocationPlugin {
  static const MethodChannel _channel =
      const MethodChannel('shipping_location_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // 初始化部标定位SDK
  static Future<String> init(
      appId, appSecurity, enterpriseSenderCode, environment) async {
    String result;
    try {
      result = await _channel.invokeMethod('init', {
        'appId': appId,
        'appSecurity': appSecurity,
        'enterpriseSenderCode': enterpriseSenderCode,
        'environment': environment
      });
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
    print("$result");
    return result;
  }

  // SDK开始运货接口
  static Future<String> start(shippingNoteNumber,serialNumber,startCountrySubdivisionCode,endCountrySubdivisionCode) async {
    String result;
    try {
      result = await _channel.invokeMethod('start', {
        'shippingNoteNumber': shippingNoteNumber,
        'serialNumber': serialNumber,
        'startCountrySubdivisionCode': startCountrySubdivisionCode,
        'endCountrySubdivisionCode': endCountrySubdivisionCode
      });
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
    print("$result");
    return result;
  }

  // SDK确认送达接口
  static Future<String> stop(shippingNoteNumber,serialNumber,startCountrySubdivisionCode,endCountrySubdivisionCode) async {
    String result;
    try {
      result = await _channel.invokeMethod('stop', {
        'shippingNoteNumber': shippingNoteNumber,
        'serialNumber': serialNumber,
        'startCountrySubdivisionCode': startCountrySubdivisionCode,
        'endCountrySubdivisionCode': endCountrySubdivisionCode
      });
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
    print("$result");
    return result;
  }

  // Android返回桌面功能接口，跟部标SDK没有关系，暂时放在这里，以后单独创建插件
  static Future<bool> backDesktop() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('backDesktop');
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
    print("$result");
    return result;
  }
}
