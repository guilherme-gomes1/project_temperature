import 'package:flutter/material.dart';
import 'package:project_temperature/src/pages/home_page/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      initialRoute: '/',

      routes: {
        '/':(context) => const HomePage(),
      },
    );
  }
}
