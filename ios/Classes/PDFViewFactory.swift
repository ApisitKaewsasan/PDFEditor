//
//  PDFViewFactory.swift
//  Runner
//
//  Created by mac on 7/7/2565 BE.
//

import Flutter
import UIKit
import MapKit
import PDFKit

@available(iOS 11.0, *)
public class PDFViewFactory: NSObject, FlutterPlatformViewFactory {
    private var reference: SwiftPdfeditorPlugin
    
    init(reference: SwiftPdfeditorPlugin) {
        self.reference = reference
        super.init()
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return PDFEditorView(frame, viewId: viewId, args: args,reference:self.reference)
    }
}

@available(iOS 11.0, *)
class PDFEditorView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let args: Any?
    let reference: SwiftPdfeditorPlugin
    var pdfView:PDFView?
    
    init(_ frame: CGRect, viewId: Int64, args: Any?,reference: SwiftPdfeditorPlugin) {
        self.frame = frame
        self.viewId = viewId
        self.args = args
        self.reference = reference
    }
    
    func view() -> UIView {
        pdfView = PDFView(frame: frame)
        self.reference._pdfEditorView = self
        if let arguments = self.args as? [String : AnyObject] {
            do{
                if((arguments["isOnline"] as! Bool)){
                    let data = try Data(contentsOf: URL(string:arguments["pathFile"] as! String)!)
                    let pdfDocument = PDFDocument(data: data)
                    pdfView?.document = pdfDocument
                }else{
                    let pdfDocument = PDFDocument(url: URL(fileURLWithPath: arguments["pathFile"] as! String))
                    pdfView?.document = pdfDocument
                }
                // set autoScales setting pdfview arguments from flutter
                if((arguments["autoScales"] as! Int) == 1){
                    pdfView?.autoScales = true
                }else{
                    pdfView?.autoScales = false
                }
                // set displayDirection setting pdfview arguments from flutter
                if((arguments["displayDirection"] as! String) == "vertical"){
                    pdfView?.displayDirection = .vertical
                }else{
                    pdfView?.displayDirection = .horizontal
                }
                
                // set displayMode setting pdfview arguments from flutter
                if((arguments["displayMode"] as! String) == "singlePageContinuous"){
                    pdfView?.displayMode = .singlePageContinuous
                }else if((arguments["displayMode"] as! String) == "singlePage"){
                    pdfView?.displayMode = .singlePage
                }else if((arguments["displayMode"] as! String) == "twoUp"){
                    pdfView?.displayMode = .twoUp
                }else {
                    pdfView?.displayMode = .twoUpContinuous
                }
                
                //Observer to close app
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(autoSavePDF(notification:)),
                                                       name: Notification.Name("autoSavePDFEnterBackground"),
                                                       object: nil)
            }catch let err{
                reference.onError(error: err.localizedDescription)
            }
        }
        return pdfView!
    }
    
    func onSave() -> String {
        //  callback path to flutter
        if let arguments = self.args as? [String : AnyObject] {
            let fullDestPath = URL(fileURLWithPath: arguments["pathFile"] as! String)
            do {
                pdfView?.document?.write(to: fullDestPath)
                return arguments["pathFile"] as! String
            } catch let error {
                reference.onError(error: error.localizedDescription)
            }
        } else {
            return "Fail: Cannot save don't path"
        }
    }
    
    func onClear(){
        //  clear view on native ios
        print("onClear xxxxx")
    }

    @objc public func autoSavePDF(notification: Notification) {
        if let arguments = self.args as? [String : AnyObject] {
            let fullDestPath = URL(fileURLWithPath: arguments["pathFile"] as! String)
            do {
                pdfView?.document?.write(to: fullDestPath)
            } catch let error {
                reference.onError(error: error.localizedDescription)
            }
        }
    }
}
