import 'package:cash_flow/features/auth/components/auth_background.dart';
import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _header(context),
            const SizedBox(height: 24),
            _cardResumo(),
            const SizedBox(height: 28),
            _titulo('Gastos'),
            const SizedBox(height: 14),
            _gastoCard('Carne e linguiça', 'R\$ 180,00'),
            _gastoCard('Bebidas', 'R\$ 120,00'),
            _gastoCard('Carvão e descartáveis', 'R\$ 45,00'),
            _gastoCard('Pão de alho', 'R\$ 30,00'),
            _gastoCard('Sobremesa', 'R\$ 75,00'),
            const SizedBox(height: 28),
            _titulo('Participantes'),
            const SizedBox(height: 14),
            _participanteCard('Kauã', 'R\$ 75,00', true),
            _participanteCard('Zé', 'R\$ 75,00', true),
            _participanteCard('Maria', 'R\$ 75,00', false),
            _participanteCard('João', 'R\$ 75,00', false),
            _participanteCard('Ana', 'R\$ 75,00', false),
            _participanteCard('Pedro', 'R\$ 75,00', false),
            const SizedBox(height: 28),
            PrimaryButton(text: 'Adicionar gasto', onPressed: () {}),
            const SizedBox(height: 12),
            SecondaryButton(text: 'Finalizar evento', onPressed: () {}),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // MARK: - Header

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AuthBackButton(onTap: () => Navigator.of(context).pop()),
            const Spacer(),
            _badgeStatus('Ativo', true),
          ],
        ),
        const SizedBox(height: 20),
        Text('Churrasco do Zé', style: AppTextStyles.title(32)),
        const SizedBox(height: 6),
        Text(
          '25 jul · Casa do Zé',
          style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.55)),
        ),
      ],
    );
  }

  // MARK: - Card resumo

  Widget _cardResumo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          _resumoItem('Total', 'R\$ 450,00'),
          _resumoDivisor(),
          _resumoItem('Por pessoa', 'R\$ 75,00'),
          _resumoDivisor(),
          _resumoItem('Pessoas', '6'),
        ],
      ),
    );
  }

  Widget _resumoItem(String label, String valor) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: AppTextStyles.body(12, color: AppColors.text.withValues(alpha: 0.45))),
          const SizedBox(height: 4),
          Text(valor, style: AppTextStyles.title(18, color: AppColors.darkGreen)),
        ],
      ),
    );
  }

  Widget _resumoDivisor() {
    return Container(width: 1, height: 36, color: AppColors.darkGreen.withValues(alpha: 0.08));
  }

  // MARK: - Card de gasto

  Widget _gastoCard(String descricao, String valor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(CupertinoIcons.cart_fill, size: 16, color: AppColors.darkGreen),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(descricao, style: AppTextStyles.body(15))),
          Text(valor, style: AppTextStyles.title(16, color: AppColors.darkGreen)),
        ],
      ),
    );
  }

  // MARK: - Card de participante

  Widget _participanteCard(String nome, String valor, bool pagou) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pagou
                  ? AppColors.green.withValues(alpha: 0.12)
                  : Colors.orange.withValues(alpha: 0.12),
            ),
            child: Center(
              child: Text(
                nome[0],
                style: AppTextStyles.button(14, color: pagou ? AppColors.darkGreen : Colors.orange.shade700),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome, style: AppTextStyles.body(15)),
                const SizedBox(height: 2),
                Text(
                  pagou ? 'Pagou' : 'Pendente',
                  style: AppTextStyles.body(12, color: pagou ? AppColors.darkGreen : Colors.orange.shade700),
                ),
              ],
            ),
          ),
          Text(valor, style: AppTextStyles.title(16, color: AppColors.darkGreen)),
          if (pagou) ...[
            const SizedBox(width: 8),
            const Icon(CupertinoIcons.check_mark_circled_solid, size: 18, color: AppColors.green),
          ],
        ],
      ),
    );
  }

  // MARK: - Pequenos widgets

  Widget _titulo(String texto) {
    return Text(
      texto.toUpperCase(),
      style: AppTextStyles.label(11, color: AppColors.text.withValues(alpha: 0.4)),
    );
  }

  Widget _badgeStatus(String texto, bool ativo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ativo ? AppColors.green.withValues(alpha: 0.15) : AppColors.text.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: AppTextStyles.body(12, color: ativo ? AppColors.darkGreen : AppColors.text.withValues(alpha: 0.5)),
      ),
    );
  }
}
