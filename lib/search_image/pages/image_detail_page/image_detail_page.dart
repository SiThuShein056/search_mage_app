import 'dart:io';

import 'package:api_lessons/search_image/ob/result_ob.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class ImageDetailPage extends StatefulWidget {
  Hits hits;
  ImageDetailPage(this.hits);

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("detail_image")),
        centerTitle: true,
      ),
      body: ListView(children: [
        CachedNetworkImage(
          imageUrl: widget.hits.webformatURL!,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        ListTile(
          leading: ClipOval(
            child: SizedBox(
              width: 45,
              height: 45,
              child: CachedNetworkImage(
                imageUrl: widget.hits.webformatURL!,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.person),
              ),
            ),
          ),
          title: Text(widget.hits.user!),
        ),
        Divider(
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(
                  Icons.remove_red_eye,
                  color: Colors.red,
                ),
                Text(
                  widget.hits.views.toString(),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.download,
                  color: Colors.blue,
                ),
                Text(
                  widget.hits.downloads.toString(),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.collections,
                  color: Colors.green,
                ),
                Text(
                  widget.hits.collections.toString(),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.comment,
                  color: Colors.indigo,
                ),
                Text(
                  widget.hits.comments.toString(),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        !isDownloaded
            ? ElevatedButton(
                onPressed: () {
                  downloadImage();
                },
                child: Text(tr("download")),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              )
            : Center(
                child: Container(
                  height: 80,
                  width: 80,
                  child: LiquidCircularProgressIndicator(
                    value: int.parse(count) / 100, // Defaults to 0.5.
                    valueColor: AlwaysStoppedAnimation(Theme.of(context)
                        .primaryColor), // Defaults to the current Theme's accentColor.
                    backgroundColor: Colors
                        .white, // Defaults to the current Theme's backgroundColor.
                    borderColor: Color.fromARGB(255, 165, 239, 27),
                    borderWidth: 5.0,
                    direction: Axis
                        .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                    center: Text(count + " % "),
                  ),
                ),
              )
      ]),
    );
  }

  bool isDownloaded = false;
  String count = "0";
  downloadImage() async {
    setState(() {
      isDownloaded = true;
    });
    Directory? directory;

    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    }

    String path = directory!.path +
        "/images/" +
        DateTime.now().millisecond.toString() +
        basename(widget.hits.largeImageURL!);
    await Dio().download(widget.hits.largeImageURL!, path,
        onReceiveProgress: (receive, total) {
      double percentage = receive / total * 100;
      setState(() {
        count = percentage.toStringAsFixed(0);
      });
      if (percentage == 100) {
        print("PATHS IS " + path.toString());

        setState(() {
          isDownloaded = false;
          count = "0";
        });
      }
    });
  }
}
