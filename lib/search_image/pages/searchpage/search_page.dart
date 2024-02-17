import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../resultpage/result_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _texController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _texController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              label: Text(tr("enter_image")),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ResultlPage(str: _texController.text);
                }));
              },
              child: Text(tr("search"))),
        ],
      ),
    );
  }
}
