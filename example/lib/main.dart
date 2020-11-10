import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shipping_location_plugin/shipping_location_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ShippingLocationPlugin.platformVersion;
      platformVersion += "\n" +
          await ShippingLocationPlugin.init(
              "com.nxzybd.che1",
              "3c3a617cee194909bec365f73a3df1e549784e7498a147b1b673fe4a904408d1",
              "6491640122MA76DQY549",
              "debug");
      platformVersion += "\n" + await ShippingLocationPlugin.start();
      platformVersion += "\n" + await ShippingLocationPlugin.stop();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }
}
