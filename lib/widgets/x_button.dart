import 'package:flutter/material.dart';

enum XButtonType { primary, secondary, outlined }

class XButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final XButtonType type;
  final IconData? icon;
  final bool fullWidth;

  const XButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = XButtonType.primary,
    this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Text(label),
            ],
          );
    Widget button;
    switch (type) {
      case XButtonType.primary:
        button = ElevatedButton(
          onPressed: onPressed,
          child: child,
        );
        break;
      case XButtonType.secondary:
        button = FilledButton.tonal(
          onPressed: onPressed,
          child: child,
        );
        break;
      case XButtonType.outlined:
        button = OutlinedButton(
          onPressed: onPressed,
          child: child,
        );
        break;
    }
    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
} 