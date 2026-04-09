import 'package:cash_flow/features/auth/presentation/widgets/auth_ui.dart';
import 'package:flutter/material.dart';

class AuthHeaderBar extends StatelessWidget {
  const AuthHeaderBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onBack,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.8),
              border: Border.all(
                color: AuthPalette.darkGreen.withValues(alpha: 0.16),
                width: 1,
              ),
            ),
            child: const Icon(
              AuthIcons.back,
              size: 16,
              color: AuthPalette.darkGreen,
            ),
          ),
        ),
        const SizedBox(height: 12),
        AuthScaleDownText(text: title, style: AuthTextStyles.display(64)),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: AuthTextStyles.body(
            18,
            color: AuthPalette.text.withValues(alpha: 0.78),
          ),
        ),
      ],
    );
  }
}

class AuthLineInput extends StatelessWidget {
  const AuthLineInput({
    super.key,
    required this.title,
    required this.placeholder,
    required this.icon,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  final String title;
  final String placeholder;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AuthTextStyles.label(
            12,
            color: AuthPalette.text.withValues(alpha: 0.62),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: 22,
              child: Icon(
                icon,
                size: 17,
                color: AuthPalette.darkGreen.withValues(alpha: 0.84),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                enableSuggestions: !obscureText,
                cursorColor: AuthPalette.darkGreen,
                style: AuthTextStyles.body(20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: placeholder,
                  hintStyle: AuthTextStyles.body(
                    20,
                    color: AuthPalette.text.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1.2,
          color: AuthPalette.darkGreen.withValues(alpha: 0.24),
        ),
      ],
    );
  }
}
