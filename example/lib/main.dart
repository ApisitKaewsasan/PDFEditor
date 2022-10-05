import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as diox;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfeditor/pdf_editor.dart';
import 'rander_pdf_view.dart';

// Filename of the PDF you'll download and save.
const fileName = '/pspdfkit-flutter-quickstart-guide.pdf';

// URL of the PDF file you'll download.
const urlServer = 'https://pspdfkit.com/downloads$fileName';

// URL of the Icon PDF Ex.
const pdfIconFile =
    "https://play-lh.googleusercontent.com/kIwlXqs28otssKK_9AKwdkB6gouex_U2WmtLshTACnwIJuvOqVvJEzewpzuYBXwXQQ";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String progressString = 'File has not been downloaded yet.';
  double progress = 0;
  bool didDownloadPDF = false;
  var file = '';
  late Directory tempDir;

  @override
  void initState() {
    super.initState();
    initdaDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PDFEditorView'),
        ),
        body: Builder(
          builder: (context) =>
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      pdfIconFile,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'First, download a PDF file. Then open it.',
                    ),
                    TextButton(
                      // Here, you download and store the PDF file in the temporary
                      // directory.
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                      onPressed: didDownloadPDF
                          ? null
                          : () async {

                        PDFEditor.download(url: urlServer,
                            savePath: tempDir.path + fileName,
                            onSuccess: (fileName){
                              setState(() {
                                log('✅ File has finished downloading. Try opening the file.');
                                didDownloadPDF = true;
                                Get.to(() => const RanderPDFView(), arguments: fileName);

                              });
                            },
                            onFailed: (e) async {
                              await FlutterPlatformAlert.showAlert(
                                windowTitle: 'PDFEditor Error!',
                                text: e,
                                alertStyle: AlertButtonStyle.ok,
                                iconStyle: IconStyle.information,
                              );
                            },
                            onProgress: (progress){
                              setState(() {
                                progressString =
                                'Download progress: ${progress.toStringAsFixed(0)}% done.';
                              });
                            });
                      },
                      child: const Text('Download a PDF file'),
                    ),
                    Text(
                      progressString,
                    ),
                    TextButton(
                      // Disable the button if no PDF is downloaded yet. Once the
                      // PDF file is downloaded, you can then open it using PSPDFKit.
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                      onPressed: !didDownloadPDF
                          ? null
                          : () async {
                        Get.to(() => const RanderPDFView(),
                            arguments: tempDir.path + fileName);
                      },
                      child: const Text(
                          'Open the downloaded file using PDFEditor'),
                    ),

                    TextButton(
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                      onPressed: !didDownloadPDF
                          ? null
                          : () async {
                        await File(tempDir.path + fileName).delete();

                        setState(() {
                          didDownloadPDF = false;
                          progressString =
                          'File has not been downloaded yet.';
                        });
                      },
                      child: const Text('Clear File PDF Temp',),
                    ),
                    const Divider(),
                    TextButton(
                      // Disable the button if no PDF is downloaded yet. Once the
                      // PDF file is downloaded, you can then open it using PSPDFKit.
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                      onPressed:  () async {
                        Get.to(() => const RanderPDFView(),
                            arguments: urlServer);
                      },
                      child: const Text(
                          'Open File Online By PDFEditor'),
                    ),

                    // PDFView(
                    //
                    // )
                  ],
                ),
              ),
        ),
      ),
    );
  }



  initdaDirectory() async {
    tempDir = await getTemporaryDirectory();
  }
}
