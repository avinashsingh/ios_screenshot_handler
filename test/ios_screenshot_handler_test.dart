import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_screenshot_handler/ios_screenshot_handler.dart';

void main() {
  const MethodChannel channel = MethodChannel('ios_screenshot_handler');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await IosScreenshotHandler.platformVersion, '42');
  });
}
