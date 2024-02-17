import 'package:api_lessons/search_image/ob/response_ob.dart';
import 'package:api_lessons/search_image/pages/downloadedImage/downloaded_image_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DownloadedImage extends StatefulWidget {
  const DownloadedImage({super.key});

  @override
  State<DownloadedImage> createState() => _DownloadedImageState();
}

class _DownloadedImageState extends State<DownloadedImage> {
  DownloadedImageOb _bloc = DownloadedImageOb();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.getDownloadedImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr("download_image"))),
      body: StreamBuilder<ResponseOb>(
          initialData: ResponseOb(msgStatge: MsgStatge.loading),
          stream: _bloc.getDownloadedStream(),
          builder: (BuildContext c, AsyncSnapshot<ResponseOb> snapshot) {
            ResponseOb respOb = snapshot.data!;
            if (respOb.msgStatge == MsgStatge.data) {
              return respOb.data.length == 0
                  ? Center(
                      child: Text(tr("no_downloaded_image")),
                    )
                  : ListView.builder(
                      itemCount: respOb.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Image.file(respOb.data[index]),
                              IconButton(
                                  onPressed: () {
                                    _bloc.getDownloadedDelete(
                                        respOb.data[index]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        );
                      });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
