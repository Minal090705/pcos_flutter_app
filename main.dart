import 'package:flutter/material.dart';
import 'screens/period_input_screen.dart';

void main() {
  runApp(const BloomApp());
}

class BloomApp extends StatelessWidget {
  const BloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLOOM',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const PeriodInputScreen(),
    );
  }
}
