import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPalette {
  static const Color green = Color.fromRGBO(36, 196, 105, 1);
  static const Color darkGreen = Color.fromRGBO(8, 110, 61, 1);
  static const Color text = Color.fromRGBO(20, 43, 33, 1);
}

class AuthTextStyles {
  const AuthTextStyles._();

  // These font names mirror the SwiftUI code so the iOS look stays aligned.
  static TextStyle display(double size, {Color color = AuthPalette.darkGreen}) {
    return TextStyle(
      fontFamily: 'AvenirNextCondensed-Heavy',
      fontSize: size,
      fontWeight: FontWeight.w900,
      height: 1,
      color: color,
    );
  }

  static TextStyle body(double size, {Color color = AuthPalette.text}) {
    return TextStyle(
      fontFamily: 'AvenirNext-Medium',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle button(double size, {Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'AvenirNext-Heavy',
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle label(double size, {required Color color}) {
    return TextStyle(
      fontFamily: 'AvenirNext-DemiBold',
      fontSize: size,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      color: color,
    );
  }
}

class AuthIcons {
  const AuthIcons._();

  static const IconData splash = CupertinoIcons.creditcard_fill;
  static const IconData group = CupertinoIcons.person_3_fill;
  static const IconData list = CupertinoIcons.list_bullet_below_rectangle;
  static const IconData paid = CupertinoIcons.check_mark_circled_solid;
  static const IconData email = CupertinoIcons.mail_solid;
  static const IconData password = CupertinoIcons.lock_fill;
  static const IconData person = CupertinoIcons.person_fill;
  static const IconData back = CupertinoIcons.arrow_left;
}

class AuthBackgroundView extends StatelessWidget {
  const AuthBackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(242, 252, 245, 1),
              Color.fromRGBO(219, 250, 232, 1),
              Color.fromRGBO(191, 240, 214, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

class AuthPageScaffold extends StatelessWidget {
  const AuthPageScaffold({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: AuthBackgroundView()),
          SafeArea(
            child: Padding(padding: padding, child: child),
          ),
        ],
      ),
    );
  }
}

class _BackgroundCircle extends StatelessWidget {
  const _BackgroundCircle({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class AuthScaleDownText extends StatelessWidget {
  const AuthScaleDownText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(text, maxLines: 1, style: style),
      ),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _AnimatedAuthButton(
      onPressed: onPressed,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AuthPalette.green, AuthPalette.darkGreen],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AuthTextStyles.button(20),
      ),
    );
  }
}

class AuthSecondaryButton extends StatelessWidget {
  const AuthSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _AnimatedAuthButton(
      onPressed: onPressed,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AuthPalette.darkGreen.withValues(alpha: 0.26),
          width: 1.2,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AuthTextStyles.button(20, color: AuthPalette.darkGreen),
      ),
    );
  }
}

class _AnimatedAuthButton extends StatefulWidget {
  const _AnimatedAuthButton({
    required this.onPressed,
    required this.decoration,
    required this.child,
  });

  final VoidCallback onPressed;
  final BoxDecoration decoration;
  final Widget child;

  @override
  State<_AnimatedAuthButton> createState() => _AnimatedAuthButtonState();
}

class _AnimatedAuthButtonState extends State<_AnimatedAuthButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) {
      return;
    }

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) => _setPressed(false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          scale: _pressed ? 0.985 : 1,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 17),
            decoration: widget.decoration,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
