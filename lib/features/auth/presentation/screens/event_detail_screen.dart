import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:cash_flow/features/event/services/event_service.dart';
import 'package:cash_flow/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatefulWidget {
  final int eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Event? _event;

  void _carregarEvento() {
    final eventService = context.read<EventService>();
    setState(() {
      _event = eventService.getEventById(widget.eventId);
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarEvento();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _carregarEvento();
  }

  String get _statusText {
    if (_event == null) return '';
    switch (_event!.status.name) {
      case 'upcoming':
        return 'Ativo';
      case 'onGoing':
        return 'Em andamento';
      case 'finalized':
        return 'Finalizado';
      case 'canceled':
        return 'Cancelado';
      default:
        return _event!.status.name;
    }
  }

  String _formatarMoeda(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  double get _totalGastos {
    if (_event == null) return 0;
    return _event!.expenditures.fold(0.0, (sum, e) => sum + e.amount);
  }

  double get _porPessoa {
    if (_event == null || _event!.participants.isEmpty) return 0;
    return _totalGastos / _event!.participants.length;
  }

  void _adicionarGasto() {
    final descController = TextEditingController();
    final valorController = TextEditingController();

    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adicionar gasto', style: AppTextStyles.title(20)),
            const SizedBox(height: 16),
            CupertinoTextField(
              controller: descController,
              placeholder: 'Descrição',
              padding: const EdgeInsets.all(12),
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: valorController,
              placeholder: 'Valor',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              padding: const EdgeInsets.all(12),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Adicionar',
              onPressed: () {
                final desc = descController.text;
                final valor = double.tryParse(valorController.text.replaceAll(',', '.'));
                if (desc.isNotEmpty && valor != null && valor > 0) {
                  context
                      .read<EventService>()
                      .addExpenditure(
                    description: desc,
                    amount: valor,
                    eventId: widget.eventId,
                  )
                      .then((_) {
                    _carregarEvento();
                    if (ctx.mounted) Navigator.of(ctx).pop();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<EventService>();

    if (_event == null) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 246, 1),
        body: SafeArea(
          child: Center(child: Text('Evento não encontrado', style: AppTextStyles.body(16))),
        ),
      );
    }

    final event = _event!;
    final ativo = event.status.name == 'upcoming' || event.status.name == 'onGoing';

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 246, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              _header(context, event),

              const SizedBox(height: 24),

              _cardResumo(event),

              const SizedBox(height: 28),

              _titulo('Gastos'),

              const SizedBox(height: 14),

              if (event.expenditures.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Nenhum gasto registrado.',
                      style: AppTextStyles.body(14,
                          color: AppColors.text.withValues(alpha: 0.5))),
                )
              else
                ...event.expenditures.map((exp) => _gastoCard(exp.description,
                    _formatarMoeda(exp.amount))),

              const SizedBox(height: 28),

              _titulo('Participantes'),

              const SizedBox(height: 14),

              if (event.participants.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Nenhum participante.',
                      style: AppTextStyles.body(14,
                          color: AppColors.text.withValues(alpha: 0.5))),
                )
              else
                ...event.participants.map((p) =>
                    _participanteCard(p.name, _formatarMoeda(_porPessoa), false)),

              const SizedBox(height: 28),

              PrimaryButton(text: 'Adicionar gasto', onPressed: _adicionarGasto),

              if (ativo) ...[
                const SizedBox(height: 12),
                SecondaryButton(
                  text: 'Finalizar evento',
                  onPressed: () {
                    context
                        .read<EventService>()
                        .finalizeEvent(widget.eventId)
                        .then((_) => _carregarEvento());
                  },
                ),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, Event event) {
    final ativo = event.status.name == 'upcoming' || event.status.name == 'onGoing';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AuthBackButton(onTap: () => Navigator.of(context).pop()),
            const Spacer(),
            _badgeStatus(_statusText, ativo),
          ],
        ),
        const SizedBox(height: 20),
        Text(event.title, style: AppTextStyles.title(32)),
        const SizedBox(height: 6),
        Text(
          '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}/${event.date.year}',
          style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.55)),
        ),
      ],
    );
  }

  Widget _cardResumo(Event event) {
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
          _resumoItem('Total', _formatarMoeda(_totalGastos)),
          _resumoDivisor(),
          _resumoItem('Por pessoa', _formatarMoeda(_porPessoa)),
          _resumoDivisor(),
          _resumoItem('Pessoas', '${event.participants.length}'),
        ],
      ),
    );
  }

  Widget _resumoItem(String label, String valor) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: AppTextStyles.body(12,
                  color: AppColors.text.withValues(alpha: 0.45))),
          const SizedBox(height: 4),
          Text(valor,
              style: AppTextStyles.title(18, color: AppColors.darkGreen)),
        ],
      ),
    );
  }

  Widget _resumoDivisor() {
    return Container(
        width: 1,
        height: 36,
        color: AppColors.darkGreen.withValues(alpha: 0.08));
  }

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
            child: const Icon(CupertinoIcons.cart_fill,
                size: 16, color: AppColors.darkGreen),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(descricao, style: AppTextStyles.body(15))),
          Text(valor, style: AppTextStyles.title(16, color: AppColors.darkGreen)),
        ],
      ),
    );
  }

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
                style: AppTextStyles.button(14,
                    color:
                        pagou ? AppColors.darkGreen : Colors.orange.shade700),
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
                  style: AppTextStyles.body(12,
                      color:
                          pagou ? AppColors.darkGreen : Colors.orange.shade700),
                ),
              ],
            ),
          ),
          Text(valor, style: AppTextStyles.title(16, color: AppColors.darkGreen)),
          if (pagou) ...[
            const SizedBox(width: 8),
            const Icon(CupertinoIcons.check_mark_circled_solid,
                size: 18, color: AppColors.green),
          ],
        ],
      ),
    );
  }

  Widget _titulo(String texto) {
    return Text(
      texto.toUpperCase(),
      style: AppTextStyles.label(11, color: AppColors.text.withValues(alpha: 0.4)),
    );
  }

  Widget _badgeStatus(String texto, bool ativo) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ativo
            ? AppColors.green.withValues(alpha: 0.15)
            : AppColors.text.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: AppTextStyles.body(12,
            color: ativo
                ? AppColors.darkGreen
                : AppColors.text.withValues(alpha: 0.5)),
      ),
    );
  }
}
