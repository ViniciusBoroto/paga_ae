import 'package:cash_flow/features/auth/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cash_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/home_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/create_event_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/event_detail_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:cash_flow/core/di/injection.dart';
import 'package:cash_flow/features/auth/services/servico_auth.dart';
import 'package:cash_flow/features/event/services/event_service.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  refreshListenable: getIt<ServicoAuth>(),

  redirect: (BuildContext context, GoRouterState state) {
    final autenticado = getIt<ServicoAuth>().autenticado;
    final rotaAtual = state.matchedLocation;
    final rotasPublicas = {'/', '/login', '/register'};
    final estaEmRotaPublica = rotasPublicas.contains(rotaAtual);

    if (!autenticado && !estaEmRotaPublica) {
      return '/login';
    }

    if (autenticado && estaEmRotaPublica) {
      return '/home';
    }

    return null;
  },

  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),

    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    GoRoute(
      path: '/create_event',
      builder: (context, state) => const CreateEventScreen(),
    ),

    GoRoute(
      path: '/event_detail',
      builder: (context, state) => const EventDetailScreen(),
    ),
  ],
);

void main() {
  setupDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<ServicoAuth>()),
        ChangeNotifierProvider.value(value: getIt<EventService>()),
      ],
      child: const MyApp(),
    ),
  );
}

// Define pra onde o app deve ir quando for iniciado que seria a WelcomeScreen
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PagaAE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(8, 110, 61, 1),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
