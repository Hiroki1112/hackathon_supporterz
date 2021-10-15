import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/registration/registration_field/registration_field.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = '/registration';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MyUser newUser = MyUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, title: '初回登録'),
      backgroundColor: AppTheme.background,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(15),
          child: ListView(
            children: [
              RegistrationField(
                headerText: 'ユーザーID(後で変更できません)',
                onChanged: (String newVal) {
                  setState(() {
                    newUser.setUserId = newVal;
                  });
                },
                hintText: 'ユーザーIDを入力してください',
              ),
              RegistrationField(
                  headerText: 'ユーザー名',
                  hintText: 'ユーザー名を入力してください',
                  onChanged: (String newVal) {
                    setState(() {
                      newUser.setUserName = newVal;
                    });
                  }),
              RegistrationField(
                  headerText: 'Twitter ID',
                  hintText: '@を抜いた TwitterIDを入力してください',
                  onChanged: (String newVal) {
                    setState(() {
                      newUser.setTwitterLink = newVal;
                    });
                  }),
              RegistrationField(
                  headerText: 'Github ID',
                  hintText: 'Github IDを入力してください',
                  onChanged: (String newVal) {
                    setState(() {
                      newUser.setGithubAccount = newVal;
                    });
                  }),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // 書き込み処理
                    await FirebaseHelper.userRegistration(newUser);
                    // /:uidに遷移する
                    Navigator.of(context)
                        .pushReplacementNamed('/' + newUser.userId);
                  }
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
    );
  }
}
