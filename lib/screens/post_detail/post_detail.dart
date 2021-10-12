import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/body_card.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/plan_text.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/user_card.dart';
import 'package:hackathon_supporterz/screens/post_detail/title/title.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostDetail extends StatefulWidget {
  static String routeName = '/detail';
  const PostDetail({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Post _post = Post();

  int _selectedIndex = 0;
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
                //Post _post = Post();
                _post = Post();
                _post.fromJson(snapshot.requireData.docs.first.data());

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DetailTitle(title: _post.title),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Text('企画'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Text('開発'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Text('制作物'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //_page[_selectedIndex],
                      Column(
                        children: [
                          //DetailTitle(title: _post.title),
                          _selectedIndex == 0
                              ? DetailBodyCard(bodyText: _post.bodyText)
                              : _selectedIndex == 1
                                  ? DetailPlanText(planeText: _post.planText)
                                  : _selectedIndex == 2
                                      ? UserCard(userId: _post.userId)
                                      : const SizedBox(height: 15),
                          UserCard(userId: _post.userId),
                        ],
                      ),
                    ],
                  ),
                );
              }

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
