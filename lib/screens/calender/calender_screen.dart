import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:hackathon_supporterz/models/event.dart';
import 'package:hackathon_supporterz/models/simple_event.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/event_tile.dart';

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

  Event _event = Event();
  List<SimpleEvent> events = <SimpleEvent>[];

  Future<void> fetchEventInfo() async {
    var db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> event =
        await db.collection('api').doc('v1').collection('event').get();

    events = event.docs.map((e) {
      SimpleEvent _event = SimpleEvent.fromJson(e.data());
      return _event;
    }).toList();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Calendar(
              startOnMonday: true,
              weekDays: ['月', '火', '水', '木', '金', '土', '日'],
              events: _calenderEvents,
              isExpandable: true,
              eventDoneColor: Colors.green,
              selectedColor: Colors.pink,
              todayColor: Colors.blue,
              // dayBuilder: (BuildContext context, DateTime day) {
              //   return new Text("!");
              // },
              eventListBuilder: (BuildContext context,
                  List<NeatCleanCalendarEvent> _selectesdEvents) {
                return new Text("");
              },
              eventColor: Colors.grey,
              locale: 'ja_JP',
              todayButtonText: '今日',
              //expandableDateFormat: 'EEEE, dd. MMMM yyyy',
              expandableDateFormat: 'yyyy年 MMMM dd EEEE',
              dayOfWeekStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 11),
            ),
            FutureBuilder(
              future: fetchEventInfo(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.hasError) {
                  return const Text('データが上手く取得されませんでした');
                }
                int eventLength = events.length;

                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: List.generate(
                      events.length,
                      (index) {
                        return Column(
                          children: [
                            Container(
                              child: EventTile(
                                simpleEvent: events[index],
                              ),
                            ),
                            //Text('a'),
                          ],
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
