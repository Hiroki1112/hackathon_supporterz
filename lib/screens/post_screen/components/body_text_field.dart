import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/card/preview_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/card/text_field_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/popup/url_embedded.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/post_inherited.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BodyTextField extends StatefulWidget {
  const BodyTextField({
    Key? key,
  }) : super(key: key);

  @override
  _BodyTextFieldState createState() => _BodyTextFieldState();
}

class _BodyTextFieldState extends State<BodyTextField> {
  bool isPreview = false;
  TextEditingController controller = TextEditingController();
  Uint8List? uploadFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '# 本文',
                style: Config.h3,
              ),
              const SizedBox(width: 15),
              IconButton(
                icon: isPreview
                    ? const Icon(
                        Icons.skip_previous,
                      )
                    : const Icon(
                        Icons.preview,
                        size: 20,
                      ),
                onPressed: () {
                  setState(() {
                    isPreview = !isPreview;
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.photo_size_select_actual_outlined,
                  size: 20,
                ),
                onPressed: () async {
                  var result = await upload();

                  if (result == CODE.failed) {
                    result = 'failed';
                  }

                  // 取得できた場合は文章中に埋め込む
                  final _newValue = controller.text + '![ ]($result)';
                  controller.value = TextEditingValue(
                    text: _newValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: _newValue.length),
                    ),
                  );
                  PostInherited.of(context, listen: false)?.post.setBodyText =
                      _newValue;
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.link,
                  size: 20,
                ),
                onPressed: () async {
                  var embed = await urlEmbedPopup(context);
                  if (embed == null) {
                    return;
                  }
                  // urlを取得したら、それを末尾に追加する
                  final _newValue =
                      controller.text + '[${embed['title']}](${embed['url']})';
                  controller.value = TextEditingValue(
                    text: _newValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: _newValue.length),
                    ),
                  );
                  PostInherited.of(context, listen: false)?.post.setBodyText =
                      _newValue;
                },
              ),
            ],
          ),
          isPreview
              ? PreviewCard(
                  rawText:
                      PostInherited.of(context, listen: false)?.post.bodyText ??
                          '')
              : TextFieldCard(
                  controller: controller,
                  onChanged: (String val) {
                    PostInherited.of(context, listen: false)?.post.setBodyText =
                        val;
                  },
                  hintText: 'あなたが開発したプロダクトについて、markdownで書いてみましょう。',
                ),
        ],
      ),
    );
  }

  Future<dynamic> upload() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    if (result != null) {
      try {
        uploadFile = result.files.single.bytes;
        return await FirebaseHelper.saveAndGetURL(uploadFile);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
