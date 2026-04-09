import 'package:cash_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:cash_flow/features/auth/presentation/widgets/auth_form_widgets.dart';
import 'package:cash_flow/features/auth/presentation/widgets/auth_ui.dart';
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

  // MARK: - Navigation

  void _openRegister() {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute<void>(builder: (_) => const RegisterScreen()),
    );
  }

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
                      const SizedBox(height: 22),
                      _forgotPassword(),
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
      title: 'Entrar',
      subtitle: 'Acesse eventos, pendências e pagamentos do grupo.',
      onBack: () => Navigator.of(context).pop(),
    );
  }

  Widget _formFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
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
            placeholder: 'Sua senha',
            icon: AuthIcons.password,
            obscureText: true,
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        'Esqueci minha senha',
        style: AuthTextStyles.body(
          15,
          color: AuthPalette.darkGreen.withValues(alpha: 0.82),
        ),
      ),
    );
  }

  Widget _actions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthPrimaryButton(text: 'Entrar', onPressed: () {}),
        const SizedBox(height: 22),
        Row(
          children: [
            Text(
              'Ainda não tem conta?',
              style: AuthTextStyles.body(
                16,
                color: AuthPalette.text.withValues(alpha: 0.72),
              ),
            ),
            TextButton(
              onPressed: _openRegister,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: Colors.transparent,
              ),
              child: Text(
                'Criar agora',
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
