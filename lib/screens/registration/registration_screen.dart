import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/registration/registration_field/registration_field.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/util/constants.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:validators/validators.dart';

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
    final firebaseUser = context.watch<User?>();

    return Scaffold(
      appBar: myAppBar(context, title: '初回登録'),
      backgroundColor: AppTheme.background,
      body: LayoutBuilder(
        builder: (context, snapshot) {
          if (Config.deviceWidth(context) > breakPoint) {
            return Form(
              key: _formKey,
              child: Center(
                child: Container(
                  width: 650,
                  //margin: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      RegistrationField(
                        headerText: 'ユーザーID(後で変更できません)',
                        onChanged: (String newVal) {
                          setState(() {
                            newUser.setUserId = newVal;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "入力してください";
                          } else if (!isAlphanumeric(val)) {
                            return "アルファベットで入力してください";
                          }
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
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "入力してください";
                          } else if (!isAlphanumeric(val)) {
                            return "アルファベットで入力してください";
                          }
                        },
                      ),
                      RegistrationField(
                        headerText: 'Twitter ID',
                        hintText: '@を抜いた TwitterIDを入力してください',
                        onChanged: (String newVal) {
                          setState(() {
                            newUser.setTwitterLink = newVal;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "入力してください";
                          } else if (!isAlphanumeric(val)) {
                            return "アルファベットで入力してください";
                          }
                        },
                      ),
                      RegistrationField(
                        headerText: 'Github ID',
                        hintText: 'Github IDを入力してください',
                        onChanged: (String newVal) {
                          setState(() {
                            newUser.setGithubAccount = newVal;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "入力してください";
                          } else if (!isAlphanumeric(val)) {
                            return "アルファベットで入力してください";
                          }
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            newUser.setFirebaseId = firebaseUser!.uid;
                            newUser.setPictureURL = firebaseUser.photoURL ?? '';
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
          } else {
            return Form(
              key: _formKey,
              child: Center(
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
                            newUser.setFirebaseId = firebaseUser!.uid;

                            newUser.setPictureURL = firebaseUser.photoURL ?? '';
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
        },
      ),
    );
  }
}
