import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 2つの選択肢のあるダイアログが表示されるウィジェット
/// buttonyesを押すとtrueが、buttonNoを押すとfalseが返される。
Future<dynamic> yesNoDialog(BuildContext context, String title, String content,
    String buttonyes, String buttonNo) async {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.blueAccent),
        ),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(buttonNo),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            child: Text(buttonyes),
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}

// 選択肢が「閉じる」のみのダイアログ
Future<dynamic> yesDialog(
    BuildContext context, String title, String content) async {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.blueAccent),
        ),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('閉じる'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}

// ユーザーに文字列を入力してもらい、それを返すダイアログ
Future<dynamic> inputDialog(
    BuildContext context, String title, String content) async {
  String _loginPassword = '';
  return showDialog<String>(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            children: [
              Text(content),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード（8～20文字）'),
                maxLength: 20,
                onChanged: (String value) {
                  _loginPassword = value;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('決定'),
            onPressed: () => Navigator.pop(context, _loginPassword),
          ),
        ],
      );
    },
  );
}
