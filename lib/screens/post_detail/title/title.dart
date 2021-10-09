import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/config.dart';

class DetailTitle extends StatelessWidget {
  const DetailTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        title,
        style: Config.h3,
      ),
    );
  }
}
