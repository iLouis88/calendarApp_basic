import 'package:calendar_app/color_board.dart';
import 'package:flutter/material.dart';


class Event {
  String title;
  DateTime startTime;
  DateTime endTime;
  List<String> attendees;
  final Color leftColor;
  final Color rightColor;
  final String? url;
  final bool isEvent;

  Event({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.attendees,
    this.leftColor = color2,
    this.rightColor = color3,
    this.url,
    this.isEvent = false,
  });

}

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDay;
  final DateTime endDay;
  final DateTime startTime;
  final DateTime endTime;
  final String eventType;
  final String? url;


  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDay,
    required this.endDay,
    required this.startTime,
    required this.endTime,
    required this.eventType,
    this.url,
  });



  // Phương thức từ Map (đọc từ Firestore)
  factory EventModel.fromMap(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      startDay: data['startDay'],
      endDay: data['endDay'],
      startTime: DateTime.parse(data['startTime']),
      endTime: DateTime.parse(data['endTime']),
      eventType: data['eventType'],
      url: data['url'],
    );
  }

  // Phương thức sang Map (lưu lên Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDay': startDay,
      'endDay': endDay,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'eventType': eventType,
      'url': url,
    };
  }
}


class ColorPair{
  final Color leftColor;
  final Color rightColor;

ColorPair({required this.leftColor, required this.rightColor});
}

