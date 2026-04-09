import 'package:cash_flow/features/auth/components/auth_background.dart';
import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_input.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/features/auth/presentation/screens/home_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // MARK: - Properties

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // MARK: - Lifecycle

  @override
  void dispose() {
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
                    const SizedBox(height: 18),
                    _forgotPassword(),
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
        Text('Entrar', style: AppTextStyles.title(36)),
        const SizedBox(height: 6),
        Text(
          'Acesse seus eventos e pagamentos do grupo.',
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
            label: 'Email',
            placeholder: 'voce@email.com',
            icon: AppIcons.email,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 22),
          AuthInput(
            label: 'Senha',
            placeholder: 'Sua senha',
            icon: AppIcons.password,
            obscureText: true,
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Esqueci minha senha',
        style: AppTextStyles.body(13, color: AppColors.darkGreen.withValues(alpha: 0.65)),
      ),
    );
  }

  Widget _actions() {
    return Column(
      children: [
        PrimaryButton(
          text: 'Entrar',
          onPressed: () {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute<void>(builder: (_) => const HomeScreen()),
            );
          },
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não tem conta? ',
              style: AppTextStyles.body(14, color: AppColors.text.withValues(alpha: 0.5)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute<void>(builder: (_) => const RegisterScreen()),
                );
              },
              child: Text('Criar agora', style: AppTextStyles.body(14, color: AppColors.darkGreen)),
            ),
          ],
        ),
      ],
    );
  }
}
