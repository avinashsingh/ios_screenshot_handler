import Flutter
import UIKit

public class SwiftIosScreenshotHandlerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_screenshot_handler", binaryMessenger: registrar.messenger())
    let instance = SwiftIosScreenshotHandlerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { notification in
        print("********-----------   Screenshot taken!")
        channel.invokeMethod("onScreenshot", arguments: nil);
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
