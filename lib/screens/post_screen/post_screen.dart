import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:markdown/markdown.dart' as markdown;

class PostScreen extends StatefulWidget {
  static String routeName = '/post';
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Post _post = Post();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: const Text(
          'Post page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView(
            children: [
              const Text('記事の名前'),
              TextFormField(
                maxLines: 1,
                maxLength: 40,
                decoration: const InputDecoration(
                  hintText: '記事を簡潔に伝える説明を書きましょう',
                ),
                onChanged: (val) {
                  setState(() {
                    _post.setTitle = val;
                  });
                },
              ),
              const Text('開発人数・期間'),
              TextFormField(
                maxLines: 1,
                onChanged: (val) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 10),
              const Text('企画・構想'),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: '例）',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onChanged: (val) {
                  setState(() {
                    _post.setPlanText = val;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('使用した技術、Tool'),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: '例）',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onChanged: (val) {
                  setState(() {
                    _post.setTechText = val;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('アピールポイント'),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: '例）',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onChanged: (val) {
                  setState(() {
                    _post.setApealText = val;
                  });
                },
              ),
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
                    onPressed: () {
                      Navigator.pop(context);
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
}
