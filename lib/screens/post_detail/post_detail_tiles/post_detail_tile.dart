import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/post.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/screens/post_detail/cards/body_card.dart';
import 'package:jiffy/screens/post_detail/cards/plan_text.dart';
import 'package:jiffy/screens/post_detail/cards/user_card.dart';
import 'package:jiffy/screens/post_detail/post_detail_tiles/post_edits_tile.dart';
import 'package:jiffy/screens/post_detail/title/title.dart';
import 'package:hexcolor/hexcolor.dart';

class PostDetailTile extends StatefulWidget {
  const PostDetailTile({
    Key? key,
    required this.postId,
    this.userId,
  }) : super(
          key: key,
        );

  final String postId;
  final String? userId;
  @override
  _PostDetailTileState createState() => _PostDetailTileState();
}

class _PostDetailTileState extends State<PostDetailTile> {
  Post _post = Post();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: FutureBuilder(
          future: FirebaseHelper.getPost(
              userId: widget.userId ?? '', postId: widget.postId),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //Post _post = Post();
              if (snapshot.data == CODE.postNotFound) {
                return NotFoundScreen();
              }
              _post = Post();
              _post.fromJson(snapshot.data!.data() ?? {});
              Color _containerColor = Colors.white;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DetailTitle(title: _post.title),
                        PostEditsTile(userId: widget.userId ?? ''),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                _containerColor = Colors.black.withOpacity(0.4);
                                _selectedIndex = 0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: _containerColor,
                                //color: Colors.black.withOpacity(0.4)
                                //color: Color(#00000000000),
                              ),
                              child: Center(child: const Text('企画')),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _containerColor = Colors.black.withOpacity(0.4);
                                _selectedIndex = 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: _containerColor,
                              ),
                              child: Center(child: const Text('開発')),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       setState(() {
                        //         _containerColor = Colors.black.withOpacity(0.4);
                        //         _selectedIndex = 2;
                        //       });
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         border: Border.all(),
                        //         color: _containerColor,
                        //       ),
                        //       child: const Center(child: Text('制作物')),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    //_page[_selectedIndex],
                    Column(
                      children: [
                        //DetailTitle(title: _post.title),
                        const SizedBox(height: 15),
                        _selectedIndex == 0
                            ? DetailPlanText(planeText: _post.planText)
                            : _selectedIndex == 1
                                ? DetailBodyCard(bodyText: _post.bodyText)
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
    );
  }
}
