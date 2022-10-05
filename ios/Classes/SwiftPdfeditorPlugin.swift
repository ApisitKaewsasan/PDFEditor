import Flutter
import UIKit

@available(iOS 11.0, *)
public class SwiftPdfeditorPlugin: NSObject, FlutterPlugin {
    var _channel: FlutterMethodChannel
    var _pdfEditorView :PDFEditorView?
    
    init(channel: FlutterMethodChannel) {
        _channel = channel
        super.init()
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "manaosoftware/pdfeditor", binaryMessenger: registrar.messenger())
      
    let instance = SwiftPdfeditorPlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
      // init MethodChannel flutter call
    
    let pdfViewFactory = PDFViewFactory(reference: instance)
    registrar.register(pdfViewFactory, withId: "PDFPlatformView")
    // init platform flutter view
  }
    

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     // call flutter to native ios
      if(call.method == "onClear"){
          _pdfEditorView?.onClear()
      }else if(call.method == "onSave"){
         result(_pdfEditorView?.onSave())
      }else if(call.method == "dismissUIAlertController"){
          UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
          result(true)
      }
      result(FlutterMethodNotImplemented)
  }
    
    // callback  native ios to flutter
    func onError(error:String) {
        _channel.invokeMethod("onError", arguments: [ "error": error])
    }
    
    // callback  native ios to flutter
    func onPageChange(total:Int,currentPage:Int){
        _channel.invokeMethod("onPageChange", arguments: ["total": total,"currentPage":currentPage])
    }
}
