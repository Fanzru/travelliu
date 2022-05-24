import 'package:flutter/material.dart';
import 'package:mobile/screen/layout/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Travelliu',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: "Poppins",
        ),
        home: const MainLayout());
  }
}
