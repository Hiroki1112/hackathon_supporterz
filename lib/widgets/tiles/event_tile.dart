import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/app_helper.dart';
import 'package:jiffy/models/event.dart';
import 'package:jiffy/models/event.dart';
import 'package:jiffy/models/simple_post.dart';
import 'package:jiffy/models/user.dart';
import 'package:jiffy/models/event.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:date_format/date_format.dart';
import 'package:jiffy/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class EventTile extends StatefulWidget {
  const EventTile({
    Key? key,
    required this.event,
  }) : super(key: key);
  final Event event;

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  var db = FirebaseFirestore.instance;
  //final String _url = widget.simpleEvent.eventLink.toString();
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    var user = db.collection('api').doc('v1').collection('user');
    AsyncMemoizer<QuerySnapshot<Map<String, dynamic>>> memo = AsyncMemoizer();
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: webWidth,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkShadow,
              spreadRadius: 1.0,
              blurRadius: 3.0,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                _launchURL(widget.event.eventLink.toString());
              },
              leading: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  AppHelper.oneEmoji(),
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 50,
                    height: 0.75,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //     future: memo
                  //         .runOnce(() async => await user.get()), //user.get(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                  //             snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.done) {
                  //         // ユーザーデータを受け取る
                  //         MyUser _user = MyUser();
                  //         _user.fromJson(snapshot.data!.docs.first.data());

                  //         return Row(
                  //           children: [
                  //             Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                 horizontal: 7.0,
                  //               ),
                  //               child: const Icon(
                  //                 Icons.people,
                  //               ),
                  //             ),
                  //             Text(
                  //               '主催' + widget.event.companyName,
                  //               style: const TextStyle(fontSize: 13),
                  //             ),
                  //           ],
                  //         );
                  //       }
                  //       return const CircularProgressIndicator();
                  //     }),
                  Text(
                    '締切' +
                        ':' +
                        formatDate(widget.event.deadline as DateTime,
                            [yyyy, '年', mm, '月', dd, '日']),
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    widget.event.eventTitle +
                        '(主催:' +
                        widget.event.companyName +
                        ')',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '開始日程' +
                            ':' +
                            formatDate(widget.event.dateStart as DateTime,
                                [yyyy, '年', mm, '月', dd, '日']),
                      ),
                      Text(
                        '終了日程' +
                            ':' +
                            formatDate(widget.event.dateEnd as DateTime,
                                [yyyy, '年', mm, '月', dd, '日']),
                      ),
                      //Text(widget.simpleEvent.dateStart.toString()),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
