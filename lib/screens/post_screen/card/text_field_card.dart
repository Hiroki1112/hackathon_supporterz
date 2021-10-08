import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';

class TextFieldCard extends StatelessWidget {
  const TextFieldCard({
    Key? key,
    required this.onChanged,
    required this.controller,
    this.hintText,
  }) : super(key: key);
  final Function onChanged;
  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkShadow,
            spreadRadius: 1.0,
            blurRadius: 3.0,
            offset: const Offset(1, 2),
          ),
        ],
        color: AppTheme.white,
      ),
      child: TextFormField(
        maxLines: 10,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.white,
          hintText: hintText ?? '',
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (val) {
          onChanged(val);
        },
        validator: (String? val) {
          // ここでのバリデーションは空でないことを確認するだけ
          if (val!.isEmpty) {
            return '内容を入力してください。';
          }
        },
      ),
    );
  }
}
