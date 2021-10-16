import 'package:cloud_firestore/cloud_firestore.dart';

class SimpleEvent {
  String companyName, eventTitle, eventLink, eventId;

  DateTime? dateStart, dateEnd, deadline;
  SimpleEvent({
    this.companyName = '',
    this.eventTitle = '',
    this.eventLink = '',
    this.eventId = '',
    //this.techTag = const [''],
    this.dateStart,
    this.dateEnd,
    this.deadline,
  });
  SimpleEvent.fromJson(Map<String, dynamic> json)
      : companyName = (json['companyName'] ?? '') as String,
        eventTitle = (json['eventTitle'] ?? '') as String,
        eventLink = (json['eventLink'] ?? '') as String,
        eventId = (json['eventId'] ?? '') as String,
        dateStart = (json['dateStart'] as Timestamp).toDate(),
        dateEnd = (json['dateEnd'] as Timestamp).toDate(),
        deadline = (json['deadline'] as Timestamp).toDate();
}
