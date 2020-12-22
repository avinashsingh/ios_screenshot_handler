import 'dart:async';
import 'dart:core';

import 'package:flutter/services.dart';
import 'dart:io';

typedef MessageHandler = Future<void> Function();

class IosScreenshotHandler {
  static const MethodChannel _channel =
      const MethodChannel('ios_screenshot_handler');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  MessageHandler onScreenshotL;
  MessageHandler onMultipleDisplaysL;

  configure (MessageHandler onScreenshot, MessageHandler onMultipleDisplays) {
    this.onScreenshotL = onScreenshot;
    this.onMultipleDisplaysL = onMultipleDisplays;
    _channel.setMethodCallHandler(_handleMethod);
    Timer.periodic(Duration(seconds: 1), (_timer) {
      recording();
      displaysCount();
    });
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    onScreenshotL();
  }

  Future<bool> recording() async {
    if (Platform.isIOS) {
      final bool recording = await _channel.invokeMethod('recording');
      if (recording) {
        print("Recording continues ${recording}");
        onScreenshotL();
      }
      return recording;
    }
    return false;
  }

  Future<int> displaysCount() async {
    if(Platform.isIOS) {
      return 1;
    }
    final int count = await _channel.invokeMethod('displayCount');
    if (count > 1) {
      onMultipleDisplaysL();
    }
    return count;
  }

}
