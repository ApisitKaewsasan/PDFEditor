import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfeditor/pdfeditor_platform_interface.dart';

import 'pdf_editor_view.dart';

class PDFViewController {
  late MethodChannel _channel;

  final PDFEditorView _widget;

  PDFViewController(int id, this._widget) {
    _channel = const MethodChannel('manaosoftware/pdfeditor');
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onPageChanged':
        String text = call.arguments as String;
        return Future.value("Text from native: $text");
      case 'onError':
        if (_widget.onError != null) {
          _widget.onError!(call.arguments['error']);
        }

        return null;

      case 'onPageChange':
        if (_widget.onPageChanged != null) {
          _widget.onPageChanged!(call.arguments['total'],call.arguments['currentPage']);
        }

        return null;
    }
  }

  Future<String?> onSave() {
    return PdfeditorPlatform.instance.onSave();
  }

  void onClear() {
    return PdfeditorPlatform.instance.onClear();
  }
}
