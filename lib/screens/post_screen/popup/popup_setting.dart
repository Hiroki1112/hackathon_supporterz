import 'package:flutter/material.dart';

/// 投稿前に必要な追加情報を入力してもらう画面
Future<dynamic> popupSetting(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text('タイトル'),
        children: <Widget>[
          // コンテンツ領域
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text('項目目'),
          ),
        ],
      );
    },
  );
}
