import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/screens/post_screen/components/card/preview_card.dart';
import 'package:jiffy/screens/post_screen/components/card/text_field_card.dart';
import 'package:jiffy/screens/post_screen/components/popup/url_embedded.dart';
import 'package:jiffy/screens/post_screen/components/post_inherited.dart';
import 'package:jiffy/util/config.dart';

class PlanTextField extends StatefulWidget {
  const PlanTextField({
    Key? key,
  }) : super(key: key);

  @override
  _PlanTextFieldState createState() => _PlanTextFieldState();
}

class _PlanTextFieldState extends State<PlanTextField> {
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
                '# 企画・構想',
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
                  PostInherited.of(context, listen: false)?.post.setPlanText =
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
                  PostInherited.of(context, listen: false)?.post.setPlanText =
                      _newValue;
                },
              ),
            ],
          ),
          isPreview
              ? PreviewCard(
                  rawText:
                      PostInherited.of(context, listen: false)?.post.planText ??
                          '')
              : TextFieldCard(
                  controller: controller,
                  onChanged: (String val) {
                    PostInherited.of(context, listen: false)?.post.setPlanText =
                        val;
                  },
                  hintText: 'どのようなプロセスでこの案に辿り着いたのかを書いてみましょう。',
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
