import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hackathon_supporterz/screens/post_screen/popup/popup_setting.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:markdown/markdown.dart' as markdown;

class PostScreen extends StatefulWidget {
  static String routeName = '/post';
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Post _post = Post();

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
              _sectionTitle('# 企画・構想'),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkShadow,
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.white,
                    hintText: 'どのようなプロセスでこの案に辿り着いたのかを書いてみましょう。',
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _post.setPlanText = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              _sectionTitle('# 本文'),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkShadow,
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.white,
                    hintText: '制作物に関してMarkdown形式で書きましょう。',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _post.setPlanText = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'プレビュー',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
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

  Widget _sectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: Config.h3,
          ),
          SizedBox(width: 15),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.remove_red_eye,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.picture_in_picture,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.link,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
