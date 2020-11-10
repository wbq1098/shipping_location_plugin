
import 'dart:async';

import 'package:flutter/services.dart';

class ShippingLocationPlugin {
  static const MethodChannel _channel =
      const MethodChannel('shipping_location_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get init async {
    final String result = await _channel.invokeMethod('init');
    print("init");
    return result;
  }

  static Future<String> get start async {
    final String result = await _channel.invokeMethod('start');
    print("start");
    return result;
  }

  static Future<String> get stop async {
    final String result = await _channel.invokeMethod('stop');
    print("stop");
    return result;
  }
}
