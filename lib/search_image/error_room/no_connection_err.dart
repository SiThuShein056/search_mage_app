import 'package:flutter/material.dart';

class NoConnectionErr extends StatelessWidget {
  Function tryAgain;
  NoConnectionErr({required this.tryAgain});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
              width: 150,
              height: 150,
              child: Image.asset("assets/images/no_connection.png"),
            ),
          ),
          SizedBox(height: 10),
          Center(
              child: Text(
            "Check your internet connection and try again",
            style: TextStyle(
              fontSize: 15,
            ),
          )),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              onPressed: () {
                tryAgain();
              },
              child: Text("Try again"))
        ]),
      ),
    );
  }
}
