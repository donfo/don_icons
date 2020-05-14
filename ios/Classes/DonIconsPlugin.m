#import "DonIconsPlugin.h"
#if __has_include(<don_icons/don_icons-Swift.h>)
#import <don_icons/don_icons-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "don_icons-Swift.h"
#endif

@implementation DonIconsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDonIconsPlugin registerWithRegistrar:registrar];
}
@end
