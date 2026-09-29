import 'package:flutter/material.dart';
import 'package:form_validation/field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Forms'), centerTitle: true),
        body: RegisterFormPage(),
      ),
    );
  }
}
