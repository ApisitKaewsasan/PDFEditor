# PDFEditor
<table>
	<tr>
		<td>
		<img alt="changing fonts with google_fonts and hot reload" src="https://www.img.in.th/images/4f35b4866f1bfa44a41f2d6f0f0ea611.png" width="100%" />
		</td>
		<td>
		<img alt="changing fonts with google_fonts and hot reload" src="https://www.img.in.th/images/4162f397932a1d355f207c948dcdfc30.png" width="100%" /></td>
	</tr>
</table>


## Getting Started

First, add the `pdfeditor` package to your [pubspec dependencies](https://pub.dev/packages/google_fonts/install).

To import `pdf_editor_view`:

```dart
import 'package:pdfeditor/pdf_editor_view.dart';
import 'package:pdfeditor/pdf_view_controller.dart';
```

To use `PDFEditorView` for show view :

```dart
late PDFViewController pdfViewController;

PDFEditorView(
            urlFile: "https://pspdfkit.com/downloads/pspdfkit-flutter-quickstart-guide.pdf",
            autoScales: true,
            onViewCreated: (controller) {
              pdfViewController = controller;
              // this.pdfViewController = controller;
            },
            onError: (error) async {
              log(error.message);
            }
          )
```

To use `pdfViewController` with an `Action`:

```dart
await pdfViewController.onSave();
// onSave for save when on change as check book in pdf
await pdfViewController.onClear();
// onClear for clear url local
```

To use  `PDFEditor.download` for download file from server or api.

```dart
PDFEditor.download(url: urlServer,
                            savePath: tempDir.path + fileName,
                            onSuccess: (fileName){
                                log('✅ File has finished downloading. Try opening the file.');
                            },
                            onFailed: (e) async {
                                log(e.message);
                            },
                            onProgress: (progress){
                              log('Download progress: ${progress.toStringAsFixed(0)}% done.');
                            });
```

```

## Testing

See [example/test](https://github.com/ApisitKaewsasan/PDFEditor.git) for testing examples.
