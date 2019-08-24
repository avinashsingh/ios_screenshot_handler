#import "IosScreenshotHandlerPlugin.h"
#import <ios_screenshot_handler/ios_screenshot_handler-Swift.h>

@implementation IosScreenshotHandlerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIosScreenshotHandlerPlugin registerWithRegistrar:registrar];
}
@end
