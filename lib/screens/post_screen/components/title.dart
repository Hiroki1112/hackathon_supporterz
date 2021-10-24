import 'package:flutter/material.dart';
import 'package:jiffy/screens/post_screen/components/post_inherited.dart';

class InputTitle extends StatefulWidget {
  const InputTitle({Key? key}) : super(key: key);

  @override
  _InputTitleState createState() => _InputTitleState();
}

class _InputTitleState extends State<InputTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        maxLines: 1,
        maxLength: 40,
        decoration: const InputDecoration(
          hintText: 'Title',
          fillColor: Colors.white,
        ),
        onChanged: (val) {
          PostInherited.of(context, listen: false)!.post.setTitle = val;
        },
        validator: (String? val) {
          if (val!.isEmpty) {
            return 'タイトルを入力してください。';
          }
        },
      ),
    );
  }
}
