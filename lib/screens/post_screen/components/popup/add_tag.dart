import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/widgets/dialog/dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as FBstorage;

/// 新しいタグを追加する際に使用するポップアップ
Future<dynamic> addTagPopup(BuildContext context) async {
  String tag = '';
  Uint8List? uploadFile;
  return showDialog<Map?>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
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
                  maxLength: 20,
                  decoration: const InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: '例）○○ハッカソン',
                  ),
                  onChanged: (String val) {
                    setState(() {
                      tag = val;
                    });
                  },
                  validator: (String? val) {
                    // ここでのバリデーションは空でないことを確認するだけ
                    if (val!.isEmpty) {
                      return 'タグを入力してください。';
                    }
                  },
                ),
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
                  Map<String, dynamic> json = {};
                  json['tag'] = tag;
                  json['image'] = uploadFile;
                  return Navigator.pop(context, json);
                }),
          ],
        );
      });
    },
  );
}
