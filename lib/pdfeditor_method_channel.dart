import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pdfeditor_platform_interface.dart';

/// An implementation of [PdfeditorPlatform] that uses method channels.
class MethodChannelPdfeditor extends PdfeditorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('manaosoftware/pdfeditor');

  @override
  Future<String?> onSave() async {
    final fileSave = await methodChannel.invokeMethod<String>('onSave');
    return fileSave;
  }

  @override
  void onClear() => methodChannel.invokeMethod('onClear');

  @override
  void dismissUIAlertController() => methodChannel.invokeMethod('dismissUIAlertController');
}
