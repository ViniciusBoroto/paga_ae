import 'package:cash_flow/models/expenditure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Expenditure', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 10,
        'description': 'Aluguel',
        'amount': 250.75,
        'eventId': 7,
      };

      final expenditure = Expenditure.fromJson(json);

      expect(expenditure.id, 10);
      expect(expenditure.description, 'Aluguel');
      expect(expenditure.amount, 250.75);
      expect(expenditure.eventId, 7);
    });

    test('toJson produz o JSON correto', () {
      const expenditure = Expenditure(
        id: 11,
        description: 'Comida',
        amount: 90.5,
        eventId: 8,
      );

      final json = expenditure.toJson();

      expect(json, {
        'id': 11,
        'description': 'Comida',
        'amount': 90.5,
        'eventId': 8,
      });
    });

    test('copyWith modifica apenas os campos especificados', () {
      const original = Expenditure(
        id: 12,
        description: 'Transporte',
        amount: 40,
        eventId: 9,
      );

      final updated = original.copyWith(amount: 55.25);

      expect(updated.id, original.id);
      expect(updated.description, original.description);
      expect(updated.amount, 55.25);
      expect(updated.eventId, original.eventId);
    });
  });
}
