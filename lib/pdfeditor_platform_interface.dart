import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pdfeditor_method_channel.dart';

abstract class PdfeditorPlatform extends PlatformInterface {
  /// Constructs a PdfeditorPlatform.
  PdfeditorPlatform() : super(token: _token);

  static final Object _token = Object();

  static PdfeditorPlatform _instance = MethodChannelPdfeditor();

  /// The default instance of [PdfeditorPlatform] to use.
  ///
  /// Defaults to [MethodChannelPdfeditor].
  static PdfeditorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PdfeditorPlatform] when
  /// they register themselves.
  static set instance(PdfeditorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> onSave() {
    throw UnimplementedError('onSave() has not been implemented.');
  }

  void onClear() {
    throw UnimplementedError('onClear() has not been implemented.');
  }

  void dismissUIAlertController() {
    throw UnimplementedError('dismissUIAlertController() has not been implemented.');
  }

}
