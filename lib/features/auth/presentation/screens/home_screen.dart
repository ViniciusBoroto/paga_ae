import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/features/auth/presentation/screens/create_event_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/event_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 246, 1),
      floatingActionButton: _botaoFlutuante(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _header(),
              const SizedBox(height: 28),
              _totalCard(),
              const SizedBox(height: 28),
              _titulo('Eventos'),
            _eventoCard(
              nome: 'Churrasco do Zé',
              data: '25 jul',
              pessoas: 6,
              total: 'R\$ 450,00',
              status: 'Ativo',
            ),
            const SizedBox(height: 12),
            _eventoCard(
              nome: 'Aniversário da Susan',
              data: '20 abr',
              pessoas: 30,
              total: 'R\$ 1.000,00',
              status: 'Finalizado',
            ),
            const SizedBox(height: 28),
            _titulo('Pendências'),
            const SizedBox(height: 14),
            _pendenciaCard(
              evento: 'Churrasco do Zé',
              valor: 'R\$ 75,00',
              prazo: 'Vence em 3 dias',
            ),
            const SizedBox(height: 12),
            _pendenciaCard(
              evento: 'Aniversário da Susan',
              valor: 'R\$ 100,00',
              prazo: 'Vence em 5 dias',
            ),
            const SizedBox(height: 100),
          ],
        ),
        ),
      ),
    );
  }

  // MARK: - Header

  Widget _header() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.7),
            border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.12)),
          ),
          child: Center(child: Text('K', style: AppTextStyles.title(20))),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá, Kauã', style: AppTextStyles.body(18)),
              const SizedBox(height: 2),
              Text(
                '2 pendências abertas',
                style: AppTextStyles.body(13, color: AppColors.text.withValues(alpha: 0.45)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.7),
              border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.12)),
            ),
            child: const Icon(CupertinoIcons.bell, size: 19, color: AppColors.darkGreen),
          ),
        ),
      ],
    );
  }

  // MARK: - Card do total

  Widget _totalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Você deve', style: AppTextStyles.body(14, color: AppColors.text.withValues(alpha: 0.45))),
          const SizedBox(height: 4),
          Text('R\$ 175,00', style: AppTextStyles.title(38, color: AppColors.darkGreen)),
          const SizedBox(height: 16),
          Row(
            children: [
              _indicador(CupertinoIcons.flame_fill, '2 eventos'),
              const SizedBox(width: 10),
              _indicador(CupertinoIcons.clock_fill, '2 pendências'),
            ],
          ),
        ],
      ),
    );
  }

  // MARK: - Card de evento

  Widget _eventoCard({
    required String nome,
    required String data,
    required int pessoas,
    required String total,
    required String status,
  }) {
    final ativo = status == 'Ativo';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(builder: (_) => const EventDetailScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(CupertinoIcons.flame_fill, size: 18, color: AppColors.darkGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nome, style: AppTextStyles.body(17)),
                      const SizedBox(height: 5),
                      _badgeStatus(status, ativo),
                    ],
                  ),
                ),
                Text(total, style: AppTextStyles.title(18, color: AppColors.darkGreen)),
              ],
            ),
            const SizedBox(height: 14),
            Container(height: 1, color: AppColors.darkGreen.withValues(alpha: 0.06)),
            const SizedBox(height: 12),
            Row(
              children: [
                _info(CupertinoIcons.calendar, data),
                const SizedBox(width: 14),
                _info(CupertinoIcons.person_2_fill, '$pessoas pessoas'),
                const Spacer(),
                Icon(CupertinoIcons.chevron_right, size: 15, color: AppColors.text.withValues(alpha: 0.25)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - Card de pendência

  Widget _pendenciaCard({
    required String evento,
    required String valor,
    required String prazo,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(CupertinoIcons.exclamationmark_circle_fill, size: 18, color: Colors.orange.shade700),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(evento, style: AppTextStyles.body(16)),
                  const SizedBox(height: 2),
                  Text(prazo, style: AppTextStyles.body(12, color: Colors.orange.shade700)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(valor, style: AppTextStyles.title(18, color: AppColors.darkGreen)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.green, AppColors.darkGreen]),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('Pagar', style: AppTextStyles.button(13)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - Botão flutuante

  Widget _botaoFlutuante() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(builder: (_) => const CreateEventScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: const LinearGradient(
            colors: [AppColors.green, AppColors.darkGreen],
          ),
          boxShadow: [
            BoxShadow(color: AppColors.darkGreen.withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(CupertinoIcons.add, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Criar evento', style: AppTextStyles.button(15)),
          ],
        ),
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

  Widget _indicador(IconData icone, String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 13, color: AppColors.darkGreen),
          const SizedBox(width: 5),
          Text(texto, style: AppTextStyles.body(12, color: AppColors.darkGreen)),
        ],
      ),
    );
  }

  Widget _badgeStatus(String texto, bool ativo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: ativo ? AppColors.green.withValues(alpha: 0.15) : AppColors.text.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: AppTextStyles.body(11, color: ativo ? AppColors.darkGreen : AppColors.text.withValues(alpha: 0.5)),
      ),
    );
  }

  Widget _info(IconData icone, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, size: 13, color: AppColors.text.withValues(alpha: 0.4)),
        const SizedBox(width: 5),
        Text(texto, style: AppTextStyles.body(13, color: AppColors.text.withValues(alpha: 0.45))),
      ],
    );
  }
}
