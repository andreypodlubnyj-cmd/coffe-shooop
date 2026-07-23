
import 'package:flutter/material.dart';
import 'screens/premium_menu_screen.dart';

void main() => runApp(const JuliamsCoffeeApp());

class JuliamsCoffeeApp extends StatelessWidget {
  const JuliamsCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Juliam's Coffee",
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4A45B),
          surface: Color(0xFF111111),
        ),
      ),
      home: const PremiumMenuScreen(),
    );
  }
}
