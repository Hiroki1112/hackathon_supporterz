import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/views/home/home_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansJP',
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
