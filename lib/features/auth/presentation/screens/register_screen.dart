import 'package:cash_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:cash_flow/features/auth/presentation/widgets/auth_form_widgets.dart';
import 'package:cash_flow/features/auth/presentation/widgets/auth_ui.dart';
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

  // MARK: - Navigation

  void _openLogin() {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute<void>(builder: (_) => const LoginScreen()),
    );
  }

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
    return AuthPageScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 22),
                      _formFields(),
                      const Spacer(),
                      _actions(),
                    ],
                  ),
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
    return AuthHeaderBar(
      title: 'Criar conta',
      subtitle: 'Comece seus eventos e divida todos os gastos em segundos.',
      onBack: () => Navigator.of(context).pop(),
    );
  }

  Widget _formFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          AuthLineInput(
            title: 'Nome',
            placeholder: 'Seu nome completo',
            icon: AuthIcons.person,
            keyboardType: TextInputType.name,
            controller: _nameController,
          ),
          const SizedBox(height: 20),
          AuthLineInput(
            title: 'Email',
            placeholder: 'voce@email.com',
            icon: AuthIcons.email,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          AuthLineInput(
            title: 'Senha',
            placeholder: 'Crie uma senha segura',
            icon: AuthIcons.password,
            obscureText: true,
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _actions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthPrimaryButton(text: 'Criar conta', onPressed: () {}),
        const SizedBox(height: 22),
        Text(
          'Ao continuar, você aceita os termos e a política de privacidade.',
          style: AuthTextStyles.body(
            13,
            color: AuthPalette.text.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Text(
              'Já tem conta?',
              style: AuthTextStyles.body(
                16,
                color: AuthPalette.text.withValues(alpha: 0.72),
              ),
            ),
            TextButton(
              onPressed: _openLogin,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: Colors.transparent,
              ),
              child: Text(
                'Entrar',
                style: AuthTextStyles.body(16, color: AuthPalette.darkGreen),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
