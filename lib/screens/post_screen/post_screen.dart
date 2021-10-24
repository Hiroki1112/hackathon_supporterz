import 'package:flutter/material.dart';
import 'package:jiffy/screens/post_screen/post_body.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:jiffy/util/constants.dart';
import 'package:jiffy/widgets/appbar/my_appbar.dart';

class PostScreen extends StatelessWidget {
  static String routeName = '/draft/new';
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, title: 'Post Page'),
      backgroundColor: AppTheme.background,
      body: LayoutBuilder(builder: (context, snapshot) {
        // PC画面の場合
        if (Config.deviceWidth(context) > breakPoint) {
          return const Center(
            child: SizedBox(
              width: webWidth,
              child: PostBody(),
            ),
          );
        } else {
          // モバイル端末の場合
          return const PostBody();
        }
      }),
    );
  }
}
