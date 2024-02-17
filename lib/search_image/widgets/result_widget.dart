// ignore_for_file: must_be_immutable

import 'package:api_lessons/search_image/ob/result_ob.dart';
import 'package:api_lessons/search_image/pages/image_detail_page/image_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  Hits hits;
  ResultWidget(this.hits);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ImageDetailPage(hits);
            }));
          },
          child: Container(
            height: 180,
            child: CachedNetworkImage(
              imageUrl: hits.webformatURL!,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        ListTile(
          leading: ClipOval(
            child: SizedBox(
              width: 45,
              height: 45,
              child: CachedNetworkImage(
                imageUrl: hits.webformatURL!,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.person),
              ),
            ),
          ),
          title: Text(hits.user!),
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
                  hits.views.toString(),
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
                  hits.downloads.toString(),
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
                  hits.collections.toString(),
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
                  hits.comments.toString(),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
