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
  Post _post = Post();

  @override
  Widget build(BuildContext context) {
    print(_post.toJson());
    return Scaffold(
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: Text("Post page"),
      ),
      body: ListView(
        children: [
          Text('記事の名前'),
          TextFormField(
            maxLines: 1,
            maxLength: 25,
            decoration: InputDecoration(
              hintText: "記事を簡潔に伝える説明を書きましょう",
            ),
            onChanged: (val) {
              setState(() {
                _post.title = val;
              });
            },
          ),
          Text('開発人数・期間'),
          TextFormField(
            maxLines: 1,
            maxLength: 25,
            onChanged: (val) {
              setState(() {});
            },
          ),
          Text('企画・構想'),
          TextFormField(
            maxLines: 10,
            maxLength: 1200,
            onChanged: (val) {
              setState(() {
                _post.plan = val;
              });
            },
          ),
          Text('使用した技術、Tool'),
          TextFormField(
            maxLines: 10,
            maxLength: 1200,
            onChanged: (val) {
              setState(() {
                _post.tech = val;
              });
            },
          ),
          Text('アピールポイント'),
          TextFormField(
            maxLines: 10,
            maxLength: 1200,
            onChanged: (val) {
              setState(() {
                _post.apeal = val;
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
                child: Text("投稿する"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
