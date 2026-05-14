import 'package:cash_flow/features/auth/components/auth_buttons.dart';
import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_flow/features/event/services/event_service.dart';


class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // Properties

  final _formKey = GlobalKey<FormState>(); //globalKey para validator()
  final _nomeController = TextEditingController();
  final _localController = TextEditingController();
  final _pixController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  // Lifecycle

  @override
  void dispose() {
    _nomeController.dispose();
    _localController.dispose();
    _pixController.dispose();
    super.dispose();
  }

   void _createEventeFormulario() {
    final formularioValido = _formKey.currentState?.validate() ?? false;

    if (!formularioValido) {
      return;
    }

    final nome = _nomeController.text;
    final local = _localController.text;
    final pix = _pixController.text;

    if (nome.isEmpty || local.isEmpty || pix.isEmpty) {
      return;
    }
    
   ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Evento criado com sucesso!')),
    );

   context.read<EventService>().createEvent(
     title: nome,
     local: local,
     pixKey: pix,
     date: _dataSelecionada,
   );

   context.go('/home');
  }

  // Actions

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
        child: Form(
          key: _formKey,
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
                _botaoCriar(),
                const SizedBox(height: 32),
              ],
            ),
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
          'Preencha os dados do Evento', style: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.55)),
        ),
      ],
    );
  }

// card info
  Widget _cardInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),

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

  Widget _botaoCriar() {
    return PrimaryButton(
      text: 'Criar evento',
      onPressed: _createEventeFormulario,
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
                TextFormField(
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
                  validator: (valor){
                    if(label == 'CHAVE PIX' && valor != null && valor.isNotEmpty){
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      final telefoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
                      final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');

                      if(!emailRegex.hasMatch(valor) && !telefoneRegex.hasMatch(valor) && !cpfRegex.hasMatch(valor)){
                        return 'Digite um CPF, email ou telefone válido';
                      }
                    }
                    if(label == 'NOME DO EVENTO' && valor != null && valor.isEmpty){
                      return 'O nome do evento é obrigatório';
                    }
                    if(label == 'LOCAL' && valor != null && valor.isEmpty){
                      return 'O local do evento é obrigatório';
                    }

                    return null;
                  },
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
