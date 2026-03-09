import 'package:cash_flow/models/enums.dart';
import 'package:cash_flow/models/event.dart';
import 'package:cash_flow/models/expenditure.dart';
import 'package:cash_flow/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 40,
        'title': 'Viagem',
        'date': '2026-04-10T09:00:00.000Z',
        'status': 'upcoming',
        'participants': [
          {'id': 1, 'name': 'Ana', 'email': 'ana@mail.com'},
          {'id': 2, 'name': 'Bruno', 'email': 'bruno@mail.com'},
        ],
        'expenditures': [
          {'id': 100, 'description': 'Hotel', 'amount': 500, 'eventId': 40},
        ],
        'createdAt': '2026-03-01T09:00:00.000Z',
        'finalizedAt': null,
        'canceledAt': null,
      };

      final event = Event.fromJson(json);

      expect(event.id, 40);
      expect(event.title, 'Viagem');
      expect(event.date, DateTime.parse('2026-04-10T09:00:00.000Z'));
      expect(event.status, EventStatus.upcoming);
      expect(event.participants.length, 2);
      expect(event.participants.first.name, 'Ana');
      expect(event.expenditures.length, 1);
      expect(event.expenditures.first.description, 'Hotel');
      expect(event.createdAt, DateTime.parse('2026-03-01T09:00:00.000Z'));
      expect(event.finalizedAt, isNull);
      expect(event.canceledAt, isNull);
    });

    test('toJson produz o JSON correto', () {
      final event = Event(
        id: 41,
        title: 'Churrasco',
        date: DateTime.parse('2026-05-15T14:00:00.000Z'),
        status: EventStatus.onGoing,
        participants: const [
          User(id: 3, name: 'Carla', email: 'carla@mail.com'),
        ],
        expenditures: const [
          Expenditure(id: 101, description: 'Carne', amount: 200, eventId: 41),
        ],
        createdAt: DateTime.parse('2026-05-01T14:00:00.000Z'),
      );

      final json = event.toJson();

      expect(json, {
        'id': 41,
        'title': 'Churrasco',
        'date': '2026-05-15T14:00:00.000Z',
        'status': 'onGoing',
        'participants': [
          {'id': 3, 'name': 'Carla', 'email': 'carla@mail.com'},
        ],
        'expenditures': [
          {'id': 101, 'description': 'Carne', 'amount': 200.0, 'eventId': 41},
        ],
        'createdAt': '2026-05-01T14:00:00.000Z',
        'finalizedAt': null,
        'canceledAt': null,
      });
    });

    test('copyWith modifica apenas os campos especificados', () {
      final original = Event(
        id: 42,
        title: 'Original',
        date: DateTime.parse('2026-06-01T10:00:00.000Z'),
        status: EventStatus.upcoming,
        participants: const [User(id: 1, name: 'Ana', email: 'ana@mail.com')],
        expenditures: const [
          Expenditure(id: 1, description: 'Item', amount: 10, eventId: 42),
        ],
        createdAt: DateTime.parse('2026-05-20T10:00:00.000Z'),
      );

      final updated = original.copyWith(
        title: 'Atualizado',
        status: EventStatus.finalized,
      );

      expect(updated.id, original.id);
      expect(updated.title, 'Atualizado');
      expect(updated.date, original.date);
      expect(updated.status, EventStatus.finalized);
      expect(updated.participants, original.participants);
      expect(updated.expenditures, original.expenditures);
      expect(updated.createdAt, original.createdAt);
      expect(updated.finalizedAt, original.finalizedAt);
      expect(updated.canceledAt, original.canceledAt);
    });
  });
}
