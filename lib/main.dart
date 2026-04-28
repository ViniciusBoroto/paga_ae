import 'package:cash_flow/features/auth/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

// Define pra onde o app deve ir quando for iniciado que seria a WelcomeScreen
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
      home: const WelcomeScreen(),
    );
  }
}
