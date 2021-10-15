import 'package:flutter/material.dart';

class RegistrationField extends StatefulWidget {
  const RegistrationField({
    Key? key,
    required this.headerText,
    required this.onChanged,
    this.hintText = '',
  }) : super(key: key);
  final String headerText;
  final String? hintText;
  final Function onChanged;

  @override
  _RegistrationFieldState createState() => _RegistrationFieldState();
}

class _RegistrationFieldState extends State<RegistrationField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.all(15),
          child: Text(widget.headerText),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: widget.hintText,
            ),
            maxLines: 1,
            maxLength: 25,
            onChanged: (val) {
              widget.onChanged(val);
            },
          ),
        ),
      ],
    );
  }
}
