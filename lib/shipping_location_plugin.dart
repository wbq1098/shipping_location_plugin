import 'dart:async';

import 'package:flutter/services.dart';

class ShippingLocationPlugin {
  static const MethodChannel _channel =
      const MethodChannel('shipping_location_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

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
}
