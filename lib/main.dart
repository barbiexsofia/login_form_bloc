import 'package:flutter/material.dart';
import 'package:login_form_bloc/login_screen.dart';
import 'package:login_form_bloc/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyPalette.backgroundColor,
      ),
      home: const LoginScreen(),
    );
  }
}

// class Palette {
//   static var gradient1;

//   static var gradient2;
// }
