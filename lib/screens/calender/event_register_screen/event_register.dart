import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/event.dart';
import 'package:provider/src/provider.dart';

class EventRegister extends StatefulWidget {
  static String routeName = '/eventRigister';
  const EventRegister({Key? key}) : super(key: key);

  @override
  _EventRegisterState createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  Event event = Event();
  //final firebaseUser = context.watch<Event?>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Container(
            width: 650,
            //margin: const EdgeInsets.all(15),
            child: ListView(
              children: [
                TextFormField(
                  onChanged: (String companyName) {
                    setState(() {
                      // newUser.setUserId = newVal;
                      event.setCompanyName = companyName;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
                ),
                TextFormField(
                  onChanged: (String eventTitle) {
                    setState(() {
                      // newUser.setUserId = newVal;
                      event.setEventTitle = eventTitle;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
                ),
                TextFormField(
                  onChanged: (String eventLink) {
                    setState(() {
                      //newUser.setUserId = newVal;
                      event.setEventLink = eventLink;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
                ),
                TextFormField(
                  onChanged: (String eventId) {
                    setState(() {
                      //newUser.setUserId = newVal;
                    });
                  },
                  //hintText: 'ユーザーIDを入力してください',
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
