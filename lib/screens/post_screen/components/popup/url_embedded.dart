import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// URLを埋め込む際に使用するポップアップ
Future<dynamic> urlEmbedPopup(BuildContext context) async {
  String _title = '';
  String _url = '';
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text(
          'URL埋め込み',
        ),
        content: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: '表示名を入力してください。',
                ),
                onChanged: (String val) {
                  _title = val;
                },
                validator: (String? val) {
                  // ここでのバリデーションは空でないことを確認するだけ
                  if (val!.isEmpty) {
                    return '表示名を入力してください。';
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'URLを入力してください',
                ),
                onChanged: (String val) {
                  _url = val;
                },
                validator: (String? val) {
                  // ここでのバリデーションは空でないことを確認するだけ
                  if (val!.isEmpty) {
                    return 'URLを入力してください。';
                  }
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('キャンセル'),
            onPressed: () => Navigator.pop(context, null),
          ),
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () =>
                Navigator.pop(context, {'title': _title, 'url': _url}),
          ),
        ],
      );
    },
  );
}
