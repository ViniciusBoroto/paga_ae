import 'package:cash_flow/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SelectLogin extends StatelessWidget {
  const SelectLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 22.0,
          right: 22.0,
          top: 150.0,
          bottom: 60.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25.0,
            children: [
              const Text(
                'PagaAE',
                style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900),
              ),
              const Text(
                'Evento criado. Conta dividida. Pix em dia.',
                style: TextStyle(fontSize: 20),
              ),
              const Text('Convide a galera para cada evento'),
              const Text('Lance gastos e veja total por pessoa'),
              const Text('Marque quem já pagou sem dor de cabeça'),
              Spacer(),
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
      ),
    );
  }
}
