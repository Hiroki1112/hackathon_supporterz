import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> successDialog(
    BuildContext context, String title, String content) async {
  return showDialog(
    context: context,
    builder: (cxt) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.blueAccent),
        ),
        content: Column(
          children: [
            Lottie.asset(
              'assets/lottie/check.json',
              height: 120,
              width: 120,
            ),
            Text(content)
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('閉じる'),
            onPressed: () => Navigator.pop(cxt),
          ),
        ],
      );
    },
  );
}
