import 'package:flutter/material.dart';
import 'package:semester_project/Screens/home_screen.dart';
import 'package:semester_project/Screens/login_screen.dart';
import 'package:semester_project/Screens/report_form_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT 110 Activity 9',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/report': (context) => const ReportFormScreen(),
      },
    );
  }
}