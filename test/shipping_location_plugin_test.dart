import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipping_location_plugin/shipping_location_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('shipping_location_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ShippingLocationPlugin.platformVersion, '42');
  });
}
