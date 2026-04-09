import 'package:cash_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:cash_flow/features/auth/presentation/widgets/auth_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectLogin extends StatelessWidget {
  const SelectLogin({super.key});

  // MARK: - Navigation

  void _openLogin(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(builder: (_) => const LoginScreen()),
    );
  }

  void _openRegister(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(builder: (_) => const RegisterScreen()),
    );
  }

  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    return AuthPageScaffold(
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Spacer(),
            _title(),
            const SizedBox(height: 18),
            _subtitle(),
            _featuresList(),
            const Spacer(),
            _actions(context),
          ],
        ),
      ),
    );
  }

  // MARK: - Sections

  Widget _title() {
    return AuthScaleDownText(
      text: 'PagaAE',
      style: AuthTextStyles.display(82),
    );
  }

  Widget _subtitle() {
    return Text(
      'Evento criado. Conta dividida. Pix em dia.',
      style: AuthTextStyles.body(
        22,
        color: AuthPalette.text.withValues(alpha: 0.82),
      ),
    );
  }

  Widget _featuresList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: const [
          _FeatureLine(
            icon: AuthIcons.group,
            text: 'Convide a galera para cada evento',
          ),
          SizedBox(height: 16),
          _FeatureLine(
            icon: AuthIcons.list,
            text: 'Lance gastos e veja total por pessoa',
          ),
          SizedBox(height: 16),
          _FeatureLine(
            icon: AuthIcons.paid,
            text: 'Marque quem já pagou sem dor de cabeça',
          ),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          AuthPrimaryButton(
            text: 'Entrar',
            onPressed: () => _openLogin(context),
          ),
          const SizedBox(height: 12),
          AuthSecondaryButton(
            text: 'Criar conta',
            onPressed: () => _openRegister(context),
          ),
        ],
      ),
    );
  }
}

// MARK: - Supporting Widgets

class _FeatureLine extends StatelessWidget {
  const _FeatureLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          child: Icon(icon, size: 16, color: AuthPalette.darkGreen),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: AuthTextStyles.body(18))),
      ],
    );
  }
}
