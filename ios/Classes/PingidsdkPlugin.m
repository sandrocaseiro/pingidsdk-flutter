#import "PingidsdkPlugin.h"
#if __has_include(<pingidsdk/pingidsdk-Swift.h>)
#import <pingidsdk/pingidsdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pingidsdk-Swift.h"
#endif

@implementation PingidsdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPingidsdkPlugin registerWithRegistrar:registrar];
}
@end
