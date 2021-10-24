import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/event.dart';
import 'package:provider/src/provider.dart';

class EventRegister extends StatefulWidget {
  static String routeName = '/eventRigister';
  const EventRegister({Key? key}) : super(key: key);

  @override
  _EventRegisterState createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  Event event = Event();
  List<DateTime> _deadlineDates = [];
  //final firebaseUser = context.watch<Event?>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Center(
          child: Container(
            width: 650,
            //margin: const EdgeInsets.all(15),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: '社名'),
                  onChanged: (String companyName) {
                    setState(() {
                      // newUser.setUserId = newVal;
                      event.setCompanyName = companyName;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'イベントタイトル'),
                  onChanged: (String eventTitle) {
                    setState(() {
                      // newUser.setUserId = newVal;
                      event.setEventTitle = eventTitle;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'イベントリンク'),
                  onChanged: (String eventLink) {
                    setState(() {
                      //newUser.setUserId = newVal;
                      event.setEventLink = eventLink;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: Text('締切'),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: Text('締切'),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: Text('締切'),
                ),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'dd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: 'Hour',
                  selectableDayPredicate: (DateTime date) {
                    // Disable weekend days to select from the calendar
                    // if (date.weekday == 6 || date.weekday == 7) {
                    //   return false;
                    // }
                    return true;
                  },
                  onChanged: (val) => print(val),
                  validator: (val) {
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                // TextFormField(
                //   : (Date newVal) {
                //     setState(() {
                //       // newUser.setUserId = newVal;
                //     });
                //   },
                //   //hintText: 'ユーザーIDを入力してください',
                // ),
                // TextFormField(
                //   onChanged: (String newVal) {
                //     setState(() {
                //       //   newUser.setUserId = newVal;
                //     });
                //   },
                //   //hintText: 'ユーザーIDを入力してください',
                // ),
                ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   newUser.setFirebaseId = firebaseUser!.uid;
                    //   newUser.setPictureURL = firebaseUser.photoURL ?? '';
                    //   // 書き込み処理
                    //   await FirebaseHelper.userRegistration(newUser);
                    //   // /:uidに遷移する

                    // }
                    FirebaseHelper.saveEvent(event);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '登録する',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
