import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFF0A4D68); // AppTheme._seaBlue
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ).createShader(bounds);
                  },
                  child: CustomPaint(
                    painter: _FlagTextPainter(_controller.value),
                    child: SizedBox(
                      height: 80,
                      width: 260,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Convert Anything, Instantly',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagTextPainter extends CustomPainter {
  final double waveValue;
  _FlagTextPainter(this.waveValue);

  @override
  void paint(Canvas canvas, Size size) {
    final text = 'XConvert';
    final style = GoogleFonts.montserrat(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 2,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    final double charWidth = textPainter.width / text.length;
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final charPainter = TextPainter(
        text: TextSpan(text: char, style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      final dx = i * charWidth;
      final dy = sin((waveValue * 2 * pi) + (i * 0.5)) * 8;
      charPainter.paint(canvas, Offset(dx, dy + (size.height - charPainter.height) / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _FlagTextPainter oldDelegate) {
    return oldDelegate.waveValue != waveValue;
  }
} 