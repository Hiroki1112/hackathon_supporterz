import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 新しいタグを追加する際に使用するポップアップ
Future<dynamic> addTagPopup(BuildContext context) async {
  String _title = '';
  String _url = '';
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text(
          'タグを入力してください',
        ),
        content: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'タグを入力してください。',
                ),
                onChanged: (String val) {
                  _title = val;
                },
                validator: (String? val) {
                  // ここでのバリデーションは空でないことを確認するだけ
                  if (val!.isEmpty) {
                    return 'タグを入力してください。';
                  }
                },
              ),
              // 画像を選択する
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
