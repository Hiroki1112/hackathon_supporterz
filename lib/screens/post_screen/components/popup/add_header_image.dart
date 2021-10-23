import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 新しいタグを追加する際に使用するポップアップ
Future<dynamic> addHeaderImage(BuildContext context) async {
  Uint8List? uploadFile;
  return showDialog<Uint8List?>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return CupertinoAlertDialog(
          title: const Text(
            'ヘッダー画像を登録してください',
          ),
          content: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: [
                uploadFile != null ? Image.memory(uploadFile!) : Container(),
                // 画像を選択する
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.image, withData: true);

                      if (result != null) {
                        try {
                          setState(() {
                            uploadFile = result.files.single.bytes;
                          });
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }
                    },
                    child: uploadFile == null
                        ? const Text(
                            '画像を選択する',
                            style: TextStyle(color: Colors.white),
                          )
                        : const Text(
                            '画像を変更する',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                )
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
                onPressed: () {
                  return Navigator.pop(context, uploadFile);
                }),
          ],
        );
      });
    },
  );
}
