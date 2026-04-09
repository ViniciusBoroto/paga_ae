import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // MARK: - Properties

  final _nomeController = TextEditingController();
  final _localController = TextEditingController();
  final _pixController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  // MARK: - Lifecycle

  @override
  void dispose() {
    _nomeController.dispose();
    _localController.dispose();
    _pixController.dispose();
    super.dispose();
  }

  // MARK: - Actions

  void _escolherData() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => Container(
        height: 260,
        color: Colors.white,
        child: CupertinoDatePicker(
          initialDateTime: _dataSelecionada,
          mode: CupertinoDatePickerMode.dateAndTime,
          use24hFormat: true,
          onDateTimeChanged: (data) {
            setState(() => _dataSelecionada = data);
          },
        ),
      ),
    );
  }

  String get _dataFormatada {
    final d = _dataSelecionada;
    final meses = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
    return '${d.day} ${meses[d.month - 1]} ${d.year} às ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  // MARK: - Body

  @override
  Widget build(BuildContext context) {
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
            _header(),
            const SizedBox(height: 32),
            _titulo('Informações'),
            const SizedBox(height: 14),
            _cardInfo(),
            const SizedBox(height: 24),
            _titulo('Pagamento'),
            const SizedBox(height: 14),
            _cardPix(),
            const SizedBox(height: 24),
            _cardDica(),
            const SizedBox(height: 24),
            _botaoCriar(),
            const SizedBox(height: 32),
          ],
        ),
        ),
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
        Text('Criar evento', style: AppTextStyles.title(36)),
        const SizedBox(height: 6),
        Text(
          'Preencha os dados e convide a galera.',
          style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.55)),
        ),
      ],
    );
  }

  Widget _cardInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          _campo(
            icone: CupertinoIcons.flame_fill,
            label: 'NOME DO EVENTO',
            placeholder: 'Ex: Churrasco do Zé',
            controller: _nomeController,
          ),
          _linha(),
          _campoData(),
          _linha(),
          _campo(
            icone: CupertinoIcons.location_solid,
            label: 'LOCAL',
            placeholder: 'Ex: Casa do Zé',
            controller: _localController,
          ),
        ],
      ),
    );
  }

  Widget _cardPix() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.1)),
      ),
      child: _campo(
        icone: CupertinoIcons.money_dollar_circle_fill,
        label: 'CHAVE PIX',
        placeholder: 'CPF, email ou telefone',
        controller: _pixController,
      ),
    );
  }

  Widget _cardDica() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkGreen.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.lightbulb_fill, size: 18, color: AppColors.darkGreen.withValues(alpha: 0.5)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Após criar, você poderá convidar pessoas e adicionar gastos.',
              style: AppTextStyles.body(13, color: AppColors.text.withValues(alpha: 0.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoCriar() {
    return PrimaryButton(
      text: 'Criar evento',
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  // MARK: - Pequenos widgets

  Widget _campo({
    required IconData icone,
    required String label,
    required String placeholder,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icone, size: 18, color: AppColors.darkGreen),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.label(11, color: AppColors.text.withValues(alpha: 0.4))),
                const SizedBox(height: 4),
                TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: AppColors.darkGreen,
                  style: AppTextStyles.body(17),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: placeholder,
                    hintStyle: AppTextStyles.body(17, color: AppColors.text.withValues(alpha: 0.3)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoData() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: GestureDetector(
        onTap: _escolherData,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(CupertinoIcons.calendar, size: 18, color: AppColors.darkGreen),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DATA E HORÁRIO', style: AppTextStyles.label(11, color: AppColors.text.withValues(alpha: 0.4))),
                  const SizedBox(height: 4),
                  Text(_dataFormatada, style: AppTextStyles.body(17)),
                ],
              ),
            ),
            Icon(CupertinoIcons.chevron_right, size: 15, color: AppColors.text.withValues(alpha: 0.25)),
          ],
        ),
      ),
    );
  }

  Widget _linha() {
    return Padding(
      padding: const EdgeInsets.only(left: 54),
      child: Container(height: 1, color: AppColors.darkGreen.withValues(alpha: 0.06)),
    );
  }

  Widget _titulo(String texto) {
    return Text(
      texto.toUpperCase(),
      style: AppTextStyles.label(11, color: AppColors.text.withValues(alpha: 0.4)),
    );
  }
}
