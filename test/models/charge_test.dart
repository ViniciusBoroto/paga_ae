import 'package:cash_flow/models/charge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Charge', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 20,
        'amount': 120.3,
        'fromUserId': 1,
        'toUserId': 2,
        'eventId': 4,
        'createdAt': '2026-03-01T10:00:00.000Z',
        'paidAt': '2026-03-02T10:00:00.000Z',
      };

      final charge = Charge.fromJson(json);

      expect(charge.id, 20);
      expect(charge.amount, 120.3);
      expect(charge.fromUserId, 1);
      expect(charge.toUserId, 2);
      expect(charge.eventId, 4);
      expect(charge.createdAt, DateTime.parse('2026-03-01T10:00:00.000Z'));
      expect(charge.paidAt, DateTime.parse('2026-03-02T10:00:00.000Z'));
    });

    test('toJson produz o JSON correto', () {
      final charge = Charge(
        id: 21,
        amount: 300,
        fromUserId: 2,
        toUserId: 3,
        eventId: 5,
        createdAt: DateTime.parse('2026-03-03T08:00:00.000Z'),
        paidAt: DateTime.parse('2026-03-04T08:00:00.000Z'),
      );

      final json = charge.toJson();

      expect(json, {
        'id': 21,
        'amount': 300.0,
        'fromUserId': 2,
        'toUserId': 3,
        'eventId': 5,
        'createdAt': '2026-03-03T08:00:00.000Z',
        'paidAt': '2026-03-04T08:00:00.000Z',
      });
    });

    test('copyWith modifica apenas os campos especificados', () {
      final original = Charge(
        id: 22,
        amount: 50,
        fromUserId: 10,
        toUserId: 11,
        eventId: 6,
        createdAt: DateTime.parse('2026-03-05T08:00:00.000Z'),
      );

      final updated = original.copyWith(amount: 75.5, toUserId: 12);

      expect(updated.id, original.id);
      expect(updated.amount, 75.5);
      expect(updated.fromUserId, original.fromUserId);
      expect(updated.toUserId, 12);
      expect(updated.eventId, original.eventId);
      expect(updated.createdAt, original.createdAt);
      expect(updated.paidAt, original.paidAt);
    });
  });
}
