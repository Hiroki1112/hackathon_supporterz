import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/home/home_body.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/util/constants.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

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
                  width: 990,
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
