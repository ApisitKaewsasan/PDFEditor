//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_platform_alert/FlutterPlatformAlertPlugin.h>)
#import <flutter_platform_alert/FlutterPlatformAlertPlugin.h>
#else
@import flutter_platform_alert;
#endif

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

#if __has_include(<pdfeditor/PdfeditorPlugin.h>)
#import <pdfeditor/PdfeditorPlugin.h>
#else
@import pdfeditor;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterPlatformAlertPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterPlatformAlertPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PdfeditorPlugin registerWithRegistrar:[registry registrarForPlugin:@"PdfeditorPlugin"]];
}

@end
