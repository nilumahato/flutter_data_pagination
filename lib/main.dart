import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagination/controller/pagination_controller.dart';
import 'package:flutter_pagination/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => PostProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
