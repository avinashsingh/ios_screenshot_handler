import 'dart:async';
import 'dart:core';

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
    Timer.periodic(Duration(seconds: 1), (_timer) {
      recording();
    });
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    onScreenshotL();
  }

  Future<bool> recording() async {
    final bool recording = await _channel.invokeMethod('recording');
    if (recording) {
      print("Recording continues ${recording}");
      onScreenshotL();
    }
    return recording;
  }

}
