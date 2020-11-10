
import 'dart:async';

import 'package:flutter/services.dart';

class ShippingLocationPlugin {
  static const MethodChannel _channel =
      const MethodChannel('shipping_location_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
