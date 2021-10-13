import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart';

class Event {
  String _companyName = '', _eventTitle = '', _eventLink = '';
  String _eventId = const Uuid().v1();
  DateTime _dateStart = DateTime.now(),
      _dateEnd = DateTime.now(),
      _deadline = DateTime.now();

  String get companyName => _companyName;
  String get eventTitle => _eventTitle;
  String get eventLink => _eventLink;
  String get eventId => _eventId;

  DateTime get dateStart => _dateStart;
  DateTime get dateEnd => _dateEnd;
  DateTime get deadline => _deadline;

  set setCompanyName(String companyName) {
    if (companyName.length <= 50) {
      _companyName = companyName;
    }
  }

  set setEventTitle(String eventTitle) {
    if (eventTitle.length <= 150) {
      _eventTitle = eventTitle;
    }
  }

  set setEventLink(String eventLink) {
    if (isURL(eventLink) && (eventLink.length < 500)) {
      _eventLink = eventLink;
    }
  }

  set setDateStart(DateTime dateStart) {
    _dateStart = dateStart;
  }

  set setDateEnd(DateTime dateEnd) {
    _dateEnd = dateEnd;
  }

  set setDeadline(DateTime deadline) {
    _deadline = deadline;
  }

  void fromJson(Map<String, dynamic> json) {
    setCompanyName = json['companyName'] as String;
    setEventTitle = json['eventTitle'] as String;
    setEventLink = json['eventLink'] as String;
    _eventId = json['eventId'] as String;
    try {
      setDateStart = (json['dateStart'] as Timestamp).toDate();
      setDateEnd = (json['dateEnd'] as Timestamp).toDate();
      setDeadline = (json['deadline'] as Timestamp).toDate();
    } catch (e) {}
  }

  Map<String, dynamic> toJson(String? userId) {
    return {
      'companyName': _companyName,
      'eventTitle': _eventTitle,
      'eventLink': _eventLink,
      'eventId': _eventId,
      'dateStart': _dateStart,
      'dateEnd': _dateEnd,
      'deadline': _deadline,
      //'userId': userId,
    };
  }
}
