import 'package:flutter_test/flutter_test.dart';
import 'package:pdfeditor/pdfeditor_platform_interface.dart';
import 'package:pdfeditor/pdfeditor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPdfeditorPlatform 
    with MockPlatformInterfaceMixin
    implements PdfeditorPlatform {

  @override
  Future<String?> onSave() {
    // TODO: implement onSave
    throw UnimplementedError();
  }

  @override
  void onClear() {
    // TODO: implement onClear
  }

  @override
  void dismissUIAlertController() {
    // TODO: implement dismissUIAlertController
  }




}

void main() {
  final PdfeditorPlatform initialPlatform = PdfeditorPlatform.instance;

  test('$MethodChannelPdfeditor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPdfeditor>());
  });

  // test('getPlatformVersion', () async {
  //   Pdfeditor pdfeditorPlugin = Pdfeditor();
  //   MockPdfeditorPlatform fakePlatform = MockPdfeditorPlatform();
  //   PdfeditorPlatform.instance = fakePlatform;
  //
  //   expect(await pdfeditorPlugin.getPlatformVersion(), '42');
  // });
}
