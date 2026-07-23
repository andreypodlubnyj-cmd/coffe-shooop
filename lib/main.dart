import 'package:flutter/material.dart';
import 'screens/premium_menu_screen.dart';

void main() {
  runApp(const JuliamsCoffeeApp());
}

class JuliamsCoffeeApp extends StatelessWidget {
  const JuliamsCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PremiumMenuScreen(),
    );
  }
}