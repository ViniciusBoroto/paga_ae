import 'package:cash_flow/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SelectLogin extends StatelessWidget {
  const SelectLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('PagaAE', style: TextStyle(fontSize: 56)),
            const Text(
              'Evento criado. Conta dividida. Pix em dia.',
              style: TextStyle(fontSize: 20),
            ),
            const Text('Convide a galera para cada evento'),
            const Text('Lance gastos e veja total por pessoa'),
            const Text('Marque quem já pagou sem dor de cabeça'),
            PrimaryButton(onPressed: () {}, text: "Entrar"),
            PrimaryButton(
              onPressed: () {},
              text: 'Criar conta',
              color: Colors.white,
              textColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
