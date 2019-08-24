import 'dart:async';

import 'package:flutter/services.dart';

typedef MessageHandler = Future<void> Function();

class IosScreenshotHandler {
  static const MethodChannel _channel =
      const MethodChannel('ios_screenshot_handler');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  MessageHandler onScreenshotL;

  configure (MessageHandler onScreenshot) {
    this.onScreenshotL = onScreenshot;
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    onScreenshotL();
  }

}
