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
  final DateTime? createdAt;
  final List<Expenditure> expenditures;

  const Event({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.participants,
    this.createdAt,
    this.expenditures = const [],
    this.finalizedAt,
    this.canceledAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      status: EventStatus.values.firstWhere(
        (status) => status.name == json['status'],
      ),
      participants:
          (json['participants'] as List<dynamic>)
              .map((user) => User.fromJson(user as Map<String, dynamic>))
              .toList(),
      expenditures:
          (json['expenditures'] as List<dynamic>?)
              ?.map(
                (expenditure) => Expenditure.fromJson(
                  expenditure as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
      finalizedAt:
          json['finalizedAt'] != null
              ? DateTime.parse(json['finalizedAt'] as String)
              : null,
      canceledAt:
          json['canceledAt'] != null
              ? DateTime.parse(json['canceledAt'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'status': status.name,
      'participants': participants.map((user) => user.toJson()).toList(),
      'expenditures': expenditures.map((exp) => exp.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'finalizedAt': finalizedAt?.toIso8601String(),
      'canceledAt': canceledAt?.toIso8601String(),
    };
  }

  Event copyWith({
    int? id,
    String? title,
    DateTime? date,
    EventStatus? status,
    List<User>? participants,
    DateTime? createdAt,
    List<Expenditure>? expenditures,
    DateTime? finalizedAt,
    DateTime? canceledAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      expenditures: expenditures ?? this.expenditures,
      finalizedAt: finalizedAt ?? this.finalizedAt,
      canceledAt: canceledAt ?? this.canceledAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Event &&
        other.id == id &&
        other.title == title &&
        other.date == date &&
        other.status == status &&
        _listEquals(other.participants, participants) &&
        other.createdAt == createdAt &&
        _listEquals(other.expenditures, expenditures) &&
        other.finalizedAt == finalizedAt &&
        other.canceledAt == canceledAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    date,
    status,
    Object.hashAll(participants),
    createdAt,
    Object.hashAll(expenditures),
    finalizedAt,
    canceledAt,
  );

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
