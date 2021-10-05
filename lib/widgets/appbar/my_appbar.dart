import 'package:flutter/material.dart';

AppBar myAppBar() {
  return AppBar(
    title: const Text('Supporterz'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
      ElevatedButton(
        onPressed: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('ろぐいん'),
        ),
      ),
    ],
  );
}
