import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('lang')),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              context.locale = Locale('en', 'US');
            },
            title: Text("English"),
            trailing: context.locale == Locale('en', 'US')
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Text("Select"),
          ),
          ListTile(
            onTap: () {
              context.locale = Locale('my', 'MM');
            },
            title: Text("မြန်မာ"),
            trailing: context.locale == Locale('my', 'MM')
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Text("Select"),
          )
        ],
      ),
    );
  }
}
