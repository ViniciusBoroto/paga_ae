import 'package:cash_flow/features/auth/components/auth_background.dart';
import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_input.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // MARK: - Properties

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // MARK: - Lifecycle

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _header(),
                    const SizedBox(height: 36),
                    _formCard(),
                    const Spacer(),
                    _actions(),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // MARK: - Sections

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthBackButton(onTap: () => Navigator.of(context).pop()),
        const SizedBox(height: 20),
        Text('Criar conta', style: AppTextStyles.title(36)),
        const SizedBox(height: 6),
        Text(
          'Comece seus eventos e divida gastos em segundos.',
          style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.55)),
        ),
      ],
    );
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          AuthInput(
            label: 'Nome',
            placeholder: 'Seu nome completo',
            icon: AppIcons.person,
            keyboardType: TextInputType.name,
            controller: _nameController,
          ),
          const SizedBox(height: 22),
          AuthInput(
            label: 'Email',
            placeholder: 'voce@email.com',
            icon: AppIcons.email,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 22),
          AuthInput(
            label: 'Senha',
            placeholder: 'Crie uma senha segura',
            icon: AppIcons.password,
            obscureText: true,
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _actions() {
    return Column(
      children: [
        PrimaryButton(text: 'Criar conta', onPressed: () {}),
        const SizedBox(height: 12),
        Text(
          'Ao continuar, você aceita os termos e a política de privacidade.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body(12, color: AppColors.text.withValues(alpha: 0.4)),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Já tem conta? ',
              style: AppTextStyles.body(14, color: AppColors.text.withValues(alpha: 0.5)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute<void>(builder: (_) => const LoginScreen()),
                );
              },
              child: Text('Entrar', style: AppTextStyles.body(14, color: AppColors.darkGreen)),
            ),
          ],
        ),
      ],
    );
  }
}
