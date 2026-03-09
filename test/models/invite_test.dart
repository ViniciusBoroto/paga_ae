import 'package:cash_flow/models/enums.dart';
import 'package:cash_flow/models/invite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Invite', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 30,
        'eventId': 9,
        'creatorId': 1,
        'inviteeId': 2,
        'status': 'accepted',
        'createdAt': '2026-03-01T12:30:00.000Z',
      };

      final invite = Invite.fromJson(json);

      expect(invite.id, 30);
      expect(invite.eventId, 9);
      expect(invite.creatorId, 1);
      expect(invite.inviteeId, 2);
      expect(invite.status, InviteStatus.accepted);
      expect(invite.createdAt, DateTime.parse('2026-03-01T12:30:00.000Z'));
    });

    test('toJson produz o JSON correto', () {
      final invite = Invite(
        id: 31,
        eventId: 10,
        creatorId: 4,
        inviteeId: 8,
        status: InviteStatus.pending,
        createdAt: DateTime.parse('2026-03-02T12:30:00.000Z'),
      );

      final json = invite.toJson();

      expect(json, {
        'id': 31,
        'eventId': 10,
        'creatorId': 4,
        'inviteeId': 8,
        'status': 'pending',
        'createdAt': '2026-03-02T12:30:00.000Z',
      });
    });

    test('copyWith modifica apenas os campos especificados', () {
      final original = Invite(
        id: 32,
        eventId: 11,
        creatorId: 7,
        inviteeId: 9,
        status: InviteStatus.pending,
        createdAt: DateTime.parse('2026-03-03T12:30:00.000Z'),
      );

      final updated = original.copyWith(status: InviteStatus.declined);

      expect(updated.id, original.id);
      expect(updated.eventId, original.eventId);
      expect(updated.creatorId, original.creatorId);
      expect(updated.inviteeId, original.inviteeId);
      expect(updated.status, InviteStatus.declined);
      expect(updated.createdAt, original.createdAt);
    });
  });
}
