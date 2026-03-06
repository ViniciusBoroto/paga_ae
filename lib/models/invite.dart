import 'package:cash_flow/models/enums.dart';

class Invite {
  final int id;
  final int eventId;
  final int creatorId;
  final int inviteeId;
  final InviteStatus status;
  final DateTime createdAt = DateTime.now();
  Invite(this.id, this.eventId, this.creatorId, this.inviteeId, this.status);

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      json['id'],
      json['eventId'],
      json['creatorId'],
      json['inviteeId'],
      InviteStatus.values.firstWhere((status) => status.name == json['status']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'creatorId': creatorId,
      'inviteeId': inviteeId,
      'status': status.name,
    };
  }
}
