import 'package:cash_flow/models/enums.dart';
import 'package:cash_flow/models/expenditure.dart';
import 'package:cash_flow/models/user.dart';

class Event {
  final int id;
  final String title;
  final DateTime date;
  final EventStatus status;
  final List<User> participants;
  final DateTime? finalizedAt;
  final DateTime? canceledAt;
  final DateTime? createdAt = DateTime.now();
  final List<Expenditure> expenditures = [];

  Event(
    this.id,
    this.title,
    this.date,
    this.status,
    this.participants, {
    this.finalizedAt,
    this.canceledAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      json['id'],
      json['title'],
      DateTime.parse(json['date']),
      EventStatus.values.firstWhere((status) => status.name == json['status']),
      json['participants'].map((user) => User.fromJson(user)).toList(),
      finalizedAt: json['finalizedAt'],
      canceledAt: json['canceledAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'status': status.name,
      'participants': participants.map((user) => user.toJson()).toList(),
      'finalizedAt': finalizedAt?.toIso8601String(),
      'canceledAt': canceledAt?.toIso8601String(),
    };
  }
}
