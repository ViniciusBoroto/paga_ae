import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logout(BuildContext context) {
    servicoAuth.logout();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 246, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              AuthBackButton(onTap: () => context.pop()),
              const SizedBox(height: 20),
              Text('Configurações', style: AppTextStyles.title(36)), 
              const Spacer(),
              PrimaryButton(text: 'Logout', onPressed: () => _logout(context)),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
