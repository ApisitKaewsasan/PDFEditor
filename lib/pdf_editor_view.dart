
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pdf_view_controller.dart';

typedef PDFViewCreatedCallback = void Function(PDFViewController controller);
typedef ErrorCallback = void Function(String error);
typedef PageChangedCallback = void Function(int? page, int? total);

class PDFEditorView extends StatefulWidget {


  final String urlFile;
  final DisplayDirection displayDirection;
  final bool autoScales;
  final DisplayMode displayMode;
  final PDFViewCreatedCallback? onViewCreated;
  final ErrorCallback? onError;
  final PageChangedCallback? onPageChanged;

  const PDFEditorView({Key? key, required this.urlFile, this.onViewCreated, this.displayDirection = DisplayDirection.vertical, this.autoScales=false, this.displayMode = DisplayMode.singlePageContinuous, this.onError, this.onPageChanged}) : super(key: key);

  @override
  State<PDFEditorView> createState() => _PDFEditorViewState();
}

class _PDFEditorViewState extends State<PDFEditorView> {


  //final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  static const StandardMessageCodec _decoder = StandardMessageCodec();
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> args = {
      "pathFile": widget.urlFile,
      "isOnline": Uri.parse(widget.urlFile).isAbsolute,
      "displayDirection": widget.displayDirection.name,
      "autoScales":widget.autoScales,
      "displayMode":widget.displayMode.name
    };
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // return AndroidView(
        //     viewType: 'PDFPlatformView',
        //     //onPlatformViewCreated: _onPlatformViewCreated,
        //     creationParams: args,
        //     creationParamsCodec: _decoder);
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: 'PDFPlatformView',
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParams: args,
            creationParamsCodec: _decoder);
      default:
        return Text('$defaultTargetPlatform is not supported');
    }
  }

  void _onPlatformViewCreated(int id) {
     PDFViewController controller = PDFViewController(id, widget);
   // _controller.complete(controller);

    if (widget.onViewCreated != null) {
      widget.onViewCreated!(controller);
    }
  }
}

enum DisplayDirection {
  vertical,
  horizontal,
}
enum DisplayMode {
  singlePageContinuous,
  singlePage,
  twoUp,
  twoUpContinuous
}

