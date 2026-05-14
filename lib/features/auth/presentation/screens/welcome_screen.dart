import 'package:cash_flow/features/auth/components/auth_background.dart';
import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Body

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            _title(),
            const SizedBox(height: 14),
            _subtitle(),
            const SizedBox(height: 36),
            _features(),
            const Spacer(flex: 3),
            _buttons(context),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'PagaAE',
      textAlign: TextAlign.center,
      style: AppTextStyles.title(58),
    );
  }

  Widget _subtitle() {
    return Text(
      'Evento criado. Conta dividida.\nPix em dia.',
      textAlign: TextAlign.center,
      style: AppTextStyles.body(
        18,
        color: AppColors.text.withValues(alpha: 0.65),
      ),
    );
  }

  Widget _features() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _featureRow(AppIcons.group, 'Convide a galera para cada evento.'),
        const SizedBox(height: 18),
        _featureRow(AppIcons.list, 'Lance gastos e veja total por pessoa.'),
        const SizedBox(height: 18),
        _featureRow(AppIcons.check, 'Marque quem já pagou.'),
      ],
    );
  }

  Widget _featureRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.7),
            border: Border.all(
              color: AppColors.darkGreen.withValues(alpha: 0.08),
            ),
          ),
          child: Icon(icon, size: 15, color: AppColors.darkGreen),
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.body(
              15,
              color: AppColors.text.withValues(alpha: 0.65),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(text: 'Entrar', onPressed: () => context.push('/login')),
        const SizedBox(height: 12),
        SecondaryButton(
          text: 'Criar conta',
          onPressed: () => context.push('/register'),
        ),
      ],
    );
  }
}
