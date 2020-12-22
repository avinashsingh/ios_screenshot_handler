package in.dgist.ios_screenshot_handler;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.hardware.display.DisplayManager;


/** IosScreenshotHandlerPlugin */
public class IosScreenshotHandlerPlugin implements MethodCallHandler {
  private final Activity activity;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "ios_screenshot_handler");
    channel.setMethodCallHandler(new IosScreenshotHandlerPlugin(registrar.activity()));
  }

  private IosScreenshotHandlerPlugin(Activity activity) {
    this.activity = activity;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("displayCount")) {
      int displayLength = ((DisplayManager)this.activity.getSystemService(this.activity.DISPLAY_SERVICE)).getDisplays().length;
      result.success(displayLength);
    } else {
      result.notImplemented();
    }
  }
}
