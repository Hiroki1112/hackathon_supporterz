import 'package:flutter/material.dart';
import 'package:jiffy/helper/app_helper.dart';

class MypageTop extends StatefulWidget {
  const MypageTop({
    Key? key,
    required this.pictureURL,
    required this.username,
  }) : super(key: key);

  final String pictureURL;
  final String username;

  @override
  _MypageTopState createState() => _MypageTopState();
}

class _MypageTopState extends State<MypageTop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.pictureURL == ''
              ? Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 15,
                  ),
                  width: 100,
                  height: 100,
                  child: Text(
                    AppHelper.oneEmoji(),
                    style: const TextStyle(fontSize: 50),
                  ),
                )
              : Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 15,
                  ),
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.pictureURL,
                    ),
                  ),
                ),
          Column(
            children: [
              widget.username != ''
                  ? Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    )
                  : const Text(
                      'widgednoName',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
