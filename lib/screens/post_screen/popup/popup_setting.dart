import 'package:flutter/material.dart';

/// 投稿前に必要な追加情報を入力してもらう画面
Future<dynamic> popupSetting(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text(
          'Setting meta Info',
        ),
        children: <Widget>[
          // コンテンツ領域
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: Column(
              children: const [
                // ヘッダー画像の入力
                Text('ヘッダー画像を選択してください。')
                //画像を選択した場合はプレビュー
              ],
            ),
          ),
        ],
      );
    },
  );
}
