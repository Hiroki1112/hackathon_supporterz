import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hackathon_supporterz/provider/auth_provider.dart';
import 'package:provider/provider.dart';

// サインインに使用するダイアログ
Future<dynamic> signIn(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text(
          'ログインしてください。',
          style: TextStyle(color: Colors.blueAccent),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignInButton(
            Buttons.Google,
            onPressed: () async {
              await context.read<AuthenticationProvider>().signInWithGoogle();
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('閉じる'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}
