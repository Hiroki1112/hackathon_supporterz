import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  static String routeName = '/post';
  const PostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post page"),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
