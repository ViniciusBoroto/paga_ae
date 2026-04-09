import 'package:cash_flow/features/auth/components/auth_styles.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    super.key,
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
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
          label.toUpperCase(),
          style: AppTextStyles.label(10, color: AppColors.text.withValues(alpha: 0.4)),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.darkGreen.withValues(alpha: 0.6)),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                autocorrect: false,
                enableSuggestions: !obscureText,
                cursorColor: AppColors.darkGreen,
                style: AppTextStyles.body(15),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: placeholder,
                  hintStyle: AppTextStyles.body(15, color: AppColors.text.withValues(alpha: 0.3)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(height: 1, color: AppColors.darkGreen.withValues(alpha: 0.12)),
      ],
    );
  }
}
