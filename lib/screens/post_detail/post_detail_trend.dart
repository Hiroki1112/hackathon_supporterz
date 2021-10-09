import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;

class PostDetailTrend extends StatefulWidget {
  static String routeName = '/detail';
  const PostDetailTrend({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;

  @override
  _PostDetailTrendState createState() => _PostDetailTrendState();
}

class _PostDetailTrendState extends State<PostDetailTrend> {
  late final WebViewController _controller;
  var db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.postId);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: FutureBuilder(
            future: db
                .collection('api')
                .doc('v1')
                .collection('posts')
                .where('postId', isEqualTo: widget.postId)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Post _post = Post();
                _post.fromJson(snapshot.requireData.docs.first.data());

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(_post.title),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.white,
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
                        child: Container(
                          // TextFormFirldは一行あたり25らしい
                          height: MediaQuery.of(context).size.height * 0.75,
                          padding: const EdgeInsets.all(10),
                          child: WebView(
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) async {
                              _controller = webViewController;
                              await _loadHTML(_post.planText);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  Future _loadHTML(String rawText) async {
    String previewHTML = '<body>' +
        md.markdownToHtml(rawText.replaceAll('\\n', '\n')) +
        '</body>';
    // iOSの場合、メタタグを付けないとテキストが小さくなるため、
    // Headerにメタタグを追加する
    String header =
        '<head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>';
    previewHTML += header;
    _controller.loadUrl(
      Uri.dataFromString(
        previewHTML,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}
