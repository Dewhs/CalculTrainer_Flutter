import 'package:calcul_trainer/pages/CalculPage.dart';
import 'package:flutter/material.dart';
import 'pages/MainPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcul Trainer',
      theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      initialRoute: MyHomePage.pageRoute,
      routes: {
        MyHomePage.pageRoute: (context) => const MyHomePage(title: "Home"),
      },
    );
  }
}
