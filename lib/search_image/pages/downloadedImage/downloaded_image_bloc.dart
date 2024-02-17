import 'dart:async';
import 'dart:io';

import 'package:api_lessons/search_image/ob/response_ob.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedImageOb {
  StreamController<ResponseOb> _controller = StreamController<ResponseOb>();
  Stream<ResponseOb> getDownloadedStream() => _controller.stream;

  getDownloadedImage() async {
    ResponseOb responseOb = ResponseOb(msgStatge: MsgStatge.loading);
    _controller.sink.add(responseOb);
    Directory? directory;

    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    }

    Directory path = Directory(directory!.path + "/images");
    //path.listSync().forEach((element) {
    //   print(element.toString());
    // });

    List<FileSystemEntity> list = path.listSync();
    list.forEach((element) {
      print(element);
    });
    responseOb.msgStatge = MsgStatge.data;
    responseOb.data = list;
    _controller.sink.add(responseOb);
  }

  getDownloadedDelete(FileSystemEntity file) {
    file.delete();
    getDownloadedImage();
  }

  dipose() {
    _controller.close();
  }
}
