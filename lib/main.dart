import 'package:cash_flow/features/auth/presentation/screens/select_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PagaAE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(8, 110, 61, 1),
        ),
        useMaterial3: true,
      ),
      home: const SelectLogin(),
    );
  }
}
