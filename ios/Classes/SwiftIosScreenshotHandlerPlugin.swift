import Flutter
import UIKit

public class SwiftIosScreenshotHandlerPlugin: NSObject, FlutterPlugin {
  var channel: FlutterMethodChannel
  var videoCaptured: Bool

  init(channel: FlutterMethodChannel) {
    self.channel = channel
    self.videoCaptured = false
  }
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_screenshot_handler", binaryMessenger: registrar.messenger())
    let instance = SwiftIosScreenshotHandlerPlugin(channel: channel)
    instance.videoCaptured = false
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { notification in
        print("********-----------   Screenshot taken!")
        channel.invokeMethod("onScreenshot", arguments: nil);
    }
    UIScreen.main.addObserver(instance, forKeyPath: "captured", options: .new, context: nil)
    if #available(iOS 11.0, *) {
      videoCaptured = UIScreen.main.isCaptured
    }
  }

  
  public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    print("&&&&&&&&&&&&&&&&   some event received")
    if (keyPath == "captured") {
      if #available(iOS 11.0, *) {
        let isCaptured = UIScreen.main.isCaptured
        self.videoCaptured = isCaptured

        channel.invokeMethod("onScreenshot", arguments: nil);
        print("************************** IS CAPTURED")
        print(isCaptured)
      }
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
    case "recording":
      result(videoCaptured)
    default:
      result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
