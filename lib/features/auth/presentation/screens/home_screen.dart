import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/features/auth/presentation/screens/create_event_screen.dart';
import 'package:cash_flow/features/auth/presentation/screens/event_detail_screen.dart';
import 'package:cash_flow/features/auth/services/servico_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cash_flow/features/event/services/event_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    final eventService = context.watch<EventService>();
    final eventos = eventService.events;
    final pendencies = eventService.pendencies;
    final totalOwed = eventService.totalOwed;

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

              _totalCard(totalOwed, eventos.length, pendencies.length),

              const SizedBox(height: 28),

              
              _titulo('Eventos'),
              const SizedBox(height: 14),

              if (eventos.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('Nenhum evento criado ainda.', style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.5))),
                )
              else
                ...eventos.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _eventoCard(
                    eventId: e.id,
                    nome: e.title,
                    data: '${e.date.day.toString().padLeft(2, '0')}/${e.date.month.toString().padLeft(2, '0')}',
                    pessoas: e.participants.length,
                    total: 'R\$ 0,00',
                    status: e.status.name == 'upcoming' ? 'Ativo' : e.status.name,
                  ),
                )),

            const SizedBox(height: 16),

            _titulo('Pendências'),

            if (pendencies.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Nenhuma pendência!', style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.5))),
              )
            else
              ...pendencies.map((charge) {
                final evento = eventService.getEventById(charge.eventId);
                final nomeEvento = evento?.title ?? 'Evento deletado';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _pendenciaCard(
                    evento: nomeEvento,
                    valor: 'R\$ ${charge.amount.toStringAsFixed(2).replaceAll('.', ',')}',
                    prazo: 'Vence em breve',
                    onPay: () => context.read<EventService>().payCharge(charge.id),
                  ),
                );
              }),

            const SizedBox(height: 100),
          ],
        ),
        ),
      ),
    );
  }

  // Header

  Widget _header() {
    final authService = context.watch<ServicoAuth>();
    final userName = authService.currentUser?.name ?? 'Usuário';
    final initial = userName.isNotEmpty ? userName[0].toUpperCase() : '?';

    return Row(
      children: [

        GestureDetector(
          onTap: () => context.push('/settings'),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.7),
              border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.12)),
            ),
            child: Center(child: Text(initial, style: AppTextStyles.title(20))),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá, $userName', style: AppTextStyles.body(18)),
              const SizedBox(height: 2),
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

  // Card do total

  Widget _totalCard(double total, int numEventos, int numPendencias) {
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
          Text('R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}', style: AppTextStyles.title(38, color: AppColors.darkGreen)),
          const SizedBox(height: 16),

          Row(
            children: [
              _indicador(CupertinoIcons.flame_fill, '$numEventos eventos'),
              const SizedBox(width: 10),
              _indicador(CupertinoIcons.clock_fill, '$numPendencias pendências'),
            ],
          ),
        ],
      ),
    );
  }

  // Card de evento

  Widget _eventoCard({
    required int eventId,
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
          CupertinoPageRoute<void>(builder: (_) => EventDetailScreen(eventId: eventId)),
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
                //icon
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
                const SizedBox(width: 8),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(CupertinoIcons.trash, size: 20, color: Colors.redAccent),
                  onPressed: () {
                    context.read<EventService>().deleteEvent(eventId);
                  },
                ),
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
    required VoidCallback onPay,
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

                GestureDetector(
                  onTap: onPay,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.green, AppColors.darkGreen]),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('Pagar', style: AppTextStyles.button(13)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // botao criar evento

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

  // widgets axiliares

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
