import 'package:cloud_firestore/cloud_firestore.dart';

class SimplePost {
  String title, postId, headerImageUrl, userId;
  List<String> techTag;
  int good;
  DateTime? timeCreated;

  SimplePost({
    this.title = '',
    this.headerImageUrl = '',
    this.good = 0,
    this.postId = '',
    this.userId = '',
    this.techTag = const [''],
    this.timeCreated,
  });
  SimplePost.fromJson(Map<String, dynamic> json)
      : title = (json['title'] ?? '') as String,
        techTag = json['techTag'].cast<String>(),
        headerImageUrl = (json['headerImageURL'] ?? '') as String,
        postId = (json['postId'] ?? '') as String,
        userId = (json['userId'] ?? '') as String,
        good = json['goodCount'] as int,
        timeCreated = (json['timeCreated'] as Timestamp).toDate();
}
