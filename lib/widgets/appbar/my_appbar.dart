import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_screen.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Supporterz'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, MyPageScreen.routeName);
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('ろぐいん'),
        ),
      ),
    ],
  );
}
