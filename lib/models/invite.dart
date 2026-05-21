import 'package:cash_flow/models/enums.dart';

class Invite {
  final int id;
  final int eventId;
  final int creatorId;
  final int inviteeId;
  final InviteStatus status;
  final DateTime? createdAt;

  const Invite({
    required this.id,
    required this.eventId,
    required this.creatorId,
    required this.inviteeId,
    required this.status,
    this.createdAt,
  });

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      id: (json['id'] as num).toInt(),
      eventId: (json['eventId'] as num).toInt(),
      creatorId: (json['creatorId'] as num).toInt(),
      inviteeId: (json['inviteeId'] as num).toInt(),
      status: InviteStatus.values.firstWhere(
        (status) => status.name == json['status'],
      ),
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'creatorId': creatorId,
      'inviteeId': inviteeId,
      'status': status.name,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Invite.fromMap(Map<String, dynamic> map) {
    return Invite(
      id: (map['id'] as num).toInt(),
      eventId: (map['evento_id'] as num).toInt(),
      creatorId: (map['criador_id'] as num).toInt(),
      inviteeId: (map['convidado_id'] as num).toInt(),
      status: InviteStatus.values.firstWhere(
        (s) => s.name == map['status'],
      ),
      createdAt:
          map['criado_em'] != null
              ? DateTime.parse(map['criado_em'] as String)
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'evento_id': eventId,
      'criador_id': creatorId,
      'convidado_id': inviteeId,
      'status': status.name,
      'criado_em': createdAt?.toIso8601String(),
    };
  }

  Invite copyWith({
    int? id,
    int? eventId,
    int? creatorId,
    int? inviteeId,
    InviteStatus? status,
    DateTime? createdAt,
  }) {
    return Invite(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      creatorId: creatorId ?? this.creatorId,
      inviteeId: inviteeId ?? this.inviteeId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Invite &&
        other.id == id &&
        other.eventId == eventId &&
        other.creatorId == creatorId &&
        other.inviteeId == inviteeId &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    creatorId,
    inviteeId,
    status,
    createdAt,
  );
}
