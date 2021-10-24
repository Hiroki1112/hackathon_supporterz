import 'package:flutter/material.dart';
import 'package:jiffy/screens/home/home_body.dart';
import 'package:jiffy/screens/post_detail/post_detail.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:jiffy/util/constants.dart';
import 'package:jiffy/widgets/appbar/my_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: myAppBar(context),
        body: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, snapshot) {
            if (Config.deviceWidth(context) > breakPoint) {
              return const Center(
                //padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: webWidth,
                  child: HomeBody(),
                ),
              );
            } else {
              return const Center(
                child: HomeBody(),
              );
            }
          }),
        ),
      ),
    );
  }
}
