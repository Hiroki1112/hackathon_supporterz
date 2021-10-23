import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/event.dart';
import 'package:hackathon_supporterz/screens/calender/event_register_screen/event_register.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/util/constants.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/event_tile.dart';
import 'package:async/async.dart';

class CalenderScreen extends StatefulWidget {
  static String routeName = '/calenderScreen';
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final Map<DateTime, List<NeatCleanCalendarEvent>> _calenderEvents = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      NeatCleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue[700]),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      NeatCleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      NeatCleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  List<Event>? events = <Event>[];
  AsyncMemoizer<void> memo = AsyncMemoizer();

  Future<List<Event>?> fetchEventInfo() async {
    var getEvents = await FirebaseHelper.getEventInfo();

    if (getEvents == null) {
      return null;
    }

    events = getEvents.docs.map((e) => Event.fromJson(e.data())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            /*
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, EventRegister.routeName);
              },
              child: const Text('event登録'),
            ),*/
            FutureBuilder(
              future: memo.runOnce(() async => await fetchEventInfo()),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.hasError) {
                  return const Text('データが上手く取得されませんでした');
                }
                int eventLength = events!.length;

                if (snapshot.connectionState == ConnectionState.done) {
                  if (events == null) {
                    return Container();
                  }
                  return Column(
                    children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: webWidth,
                            ),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ハッカソンイベント情報',
                                      style: Config.h2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] +
                        List.generate(
                          events!.length,
                          (index) {
                            return EventTile(
                              event: events![index],
                            );

                            // return PostTile(simplePost: posts[index]);
                          },
                        ),
                  );
                }
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
