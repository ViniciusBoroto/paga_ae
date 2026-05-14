import 'package:cash_flow/models/event.dart';
import 'package:cash_flow/models/enums.dart';
import 'package:flutter/material.dart';

class EventService extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => List.unmodifiable(_events);

  void createEvent({
    required String title,
    required String local,
    required String pixKey,
    required DateTime date,
  }) {
    final newEvent = Event(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      date: date,
      status: EventStatus.upcoming,
      participants: [],
      createdAt: DateTime.now(),
    );

    _events.add(newEvent);
    notifyListeners();
  }
}
