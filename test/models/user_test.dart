import 'package:cash_flow/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {'id': 1, 'name': 'Ana', 'email': 'ana@mail.com'};

      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'Ana');
      expect(user.email, 'ana@mail.com');
    });

    test('toJson produz o JSON correto', () {
      const user = User(id: 2, name: 'Bruno', email: 'bruno@mail.com');

      final json = user.toJson();

      expect(json, {
        'id': 2,
        'name': 'Bruno',
        'email': 'bruno@mail.com',
      });
    });

    test('copyWith modifica apenas os campos especificados', () {
      const original = User(id: 3, name: 'Carlos', email: 'carlos@mail.com');

      final updated = original.copyWith(name: 'Carla');

      expect(updated.id, original.id);
      expect(updated.name, 'Carla');
      expect(updated.email, original.email);
    });
  });
}
