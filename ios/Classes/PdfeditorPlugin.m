#import "PdfeditorPlugin.h"
#if __has_include(<pdfeditor/pdfeditor-Swift.h>)
#import <pdfeditor/pdfeditor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pdfeditor-Swift.h"
#endif

@implementation PdfeditorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPdfeditorPlugin registerWithRegistrar:registrar];
}
@end
