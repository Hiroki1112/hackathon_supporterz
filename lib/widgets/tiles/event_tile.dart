import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/models/simple_event.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/models/event.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail_trend.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:date_format/date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class EventTile extends StatefulWidget {
  const EventTile({
    Key? key,
    required this.simpleEvent,
  }) : super(key: key);
  final SimpleEvent simpleEvent;

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
    return Container(
      width: Config.deviceWidth(context) * 0.9,
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
              _launchURL(widget.simpleEvent.eventLink.toString());
            },
            leading: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/dummy1.jpg',
                  height: 75,
                  width: 75,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: user.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // ユーザーデータを受け取る
                        MyUser _user = MyUser();
                        _user.fromJson(snapshot.data!.docs.first.data());

                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7.0,
                              ),
                              child: const Icon(
                                Icons.people,
                              ),
                            ),
                            Text(
                              '主催' + widget.simpleEvent.companyName,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
                Text(
                  '締切' +
                      ':' +
                      formatDate(widget.simpleEvent.deadline as DateTime,
                          [yyyy, '年', mm, '月', dd, '日']),
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                Text(
                  widget.simpleEvent.eventTitle,
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
                          formatDate(widget.simpleEvent.dateStart as DateTime,
                              [yyyy, '年', mm, '月', dd, '日']),
                    ),
                    Text(
                      '終了日程' +
                          ':' +
                          formatDate(widget.simpleEvent.dateEnd as DateTime,
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
    );
  }
}
