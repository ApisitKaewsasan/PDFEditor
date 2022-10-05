

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class PDFEditor{
  static  download({required String url, required String savePath,required Function(String) onSuccess,required Function(String) onFailed,required Function(double) onProgress}) async {
    var cancelToken = CancelToken();
    var dio = Dio();
    var progress = 0.0;
    // if(!isPDF(url)){
    //   log('🔥 Download , Allowed for pdf files only . ');
    //   onFailed.call('🔥 Download , Allowed for pdf files only . ');
    //   return null;
    // }

    try {
      log('📥 Start download from url -> $url');
      Response response = await dio.get(
        url,
        cancelToken: cancelToken,
        onReceiveProgress: (done,total){
          progress = done / total;
            if (progress >= 1) {
              log('✅ File has finished downloading. Try opening the file.');
              onSuccess.call(savePath);

            }
          onProgress.call((progress * 100));
        },
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              if(status == 200){
                return true;
              }else{
                cancelToken.cancel();
                return false;
              }
            }),
      );
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();
    } on DioError catch (e) {
     if(File(savePath).existsSync()){
       await  File(savePath).delete();
     }
      log('🔥 Download failed, please check the link . ');
      onFailed.call('🔥 Download failed, please check the link . ');

    }
  }



}