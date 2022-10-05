
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get/get.dart';
import 'package:pdfeditor/pdf_editor_view.dart';
import 'package:pdfeditor/pdf_view_controller.dart';

class RanderPDFView extends StatefulWidget {
  const RanderPDFView({Key? key}) : super(key: key);

  @override
  State<RanderPDFView> createState() => _RanderPDFViewState();
}

class _RanderPDFViewState extends State<RanderPDFView> {
  late PDFViewController pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PDF Editor"),
          actions: [
            IconButton(
                tooltip: "Clear PDF",
                onPressed: () async {
                  var alert = await FlutterPlatformAlert.showAlert(
                    windowTitle: 'PDFEditor!',
                    text: 'Do you want to clear the data?',
                    alertStyle: AlertButtonStyle.okCancel,
                    iconStyle: IconStyle.information,
                  );
                  if (alert == AlertButton.okButton) {
                    pdfViewController.onClear();
                  }
                },
                icon: const Icon(Icons.cleaning_services_rounded)),
          ],
        ),
        body: Center(
          child: PDFEditorView(
            urlFile: Get.arguments,
            autoScales: true,
            onViewCreated: (controller) {
              pdfViewController = controller;
              // this.pdfViewController = controller;
            },
            onError: (error) async {
              await FlutterPlatformAlert.showAlert(
                windowTitle: 'PDFEditor Error!',
                text: error,
                alertStyle: AlertButtonStyle.ok,
                iconStyle: IconStyle.information,
              );
              Get.back();
            }
          ),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            tooltip: "Save PDF",
            onPressed: () async {
              var fileName = await pdfViewController.onSave();
              await FlutterPlatformAlert.showAlert(
                windowTitle: 'PDFEditor Success!',
                text: fileName.toString(),
                alertStyle: AlertButtonStyle.ok,
                iconStyle: IconStyle.information,
              );
              Get.back();
            },
            child: const Icon(Icons.save_alt)));
  }
}
