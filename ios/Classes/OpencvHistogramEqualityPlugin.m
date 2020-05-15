#import "OpencvHistogramEqualityPlugin.h"
#if __has_include(<opencv_histogram_equality/opencv_histogram_equality-Swift.h>)
#import <opencv_histogram_equality/opencv_histogram_equality-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "opencv_histogram_equality-Swift.h"
#endif

@implementation OpencvHistogramEqualityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpencvHistogramEqualityPlugin registerWithRegistrar:registrar];
}
@end
