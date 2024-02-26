import 'package:assestment/view/login.view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assesment',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}
