import 'package:flutter/material.dart';
import 'package:interview_rajkot/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/item_list_controller.dart';


void main() {
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ItemListController()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}