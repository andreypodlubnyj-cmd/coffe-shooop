import 'package:flutter/material.dart';

import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _startSplash();
  }

  Future<void> _startSplash() async {
    await _controller.forward();
    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) {
      return;
    }

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(
          milliseconds: 650,
        ),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return const MenuScreen();
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          final Animation<Offset> slideAnimation =
              Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF251915),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -100,
            right: -90,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(
                  alpha: 0.035,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -130,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD4A574).withValues(
                  alpha: 0.08,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 138,
                        height: 138,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F1EA),
                          borderRadius: BorderRadius.circular(42),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 35,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return const Icon(
                              Icons.local_cafe_rounded,
                              size: 76,
                              color: Color(0xFF37251F),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        "JULIAM'S",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'COFFEE',
                        style: TextStyle(
                          color: Color(0xFFD7B594),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 8,
                        ),
                      ),
                      const SizedBox(height: 42),
                      const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: Color(0xFFD7B594),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Готуємо щось особливе...',
                        style: TextStyle(
                          color: Color(0xFFBCAEA7),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}