import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/screens/post_screen/card/text_field_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/popup/popup_setting.dart';
import 'package:hackathon_supporterz/screens/post_screen/card/preview_card.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

class PostScreen extends StatefulWidget {
  static String routeName = '/post';
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Post _post = Post();
  bool planIsPreview = false;
  bool bodyIsPreview = false;

  final TextEditingController _planTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bodyTextController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, title: 'Post Page'),
      backgroundColor: AppTheme.background,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView(
            children: [
              TextFormField(
                maxLines: 1,
                maxLength: 40,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  fillColor: Colors.white,
                ),
                onChanged: (val) {
                  setState(() {
                    _post.setTitle = val;
                  });
                },
              ),
              const SizedBox(height: 10),
              _sectionTitle(
                '# 企画・構想',
                () {
                  setState(() {
                    planIsPreview = !planIsPreview;
                  });
                },
                _planTextController,
              ),
              planIsPreview
                  ? PreviewCard(rawText: _post.planText)
                  : TextFieldCard(
                      controller: _planTextController,
                      onChanged: (String val) {
                        setState(() {
                          _post.setPlanText = val;
                        });
                      },
                      hintText: 'どのようなプロセスでこの案に辿り着いたのかを書いてみましょう。',
                    ),
              const SizedBox(height: 10),
              _sectionTitle(
                '# 本文',
                () {
                  setState(() {
                    bodyIsPreview = !bodyIsPreview;
                  });
                },
                _bodyTextController,
              ),
              bodyIsPreview
                  ? PreviewCard(rawText: _post.bodyText)
                  : TextFieldCard(
                      controller: _bodyTextController,
                      onChanged: (String val) {
                        setState(() {
                          _post.setBodyText = val;
                        });
                      },
                      hintText: '制作物に関してMarkdown形式で書きましょう。',
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await popupSetting(context);
                      //Navigator.pop(context);
                    },
                    child: const Text(
                      '投稿する',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(
      String title, Function onEyePressed, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: Config.h3,
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(
              Icons.remove_red_eye,
              size: 20,
            ),
            onPressed: () {
              onEyePressed();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.photo_size_select_actual_outlined,
              size: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.link,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
