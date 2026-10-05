import 'package:flutter/material.dart';
import 'package:scholar_chat/login/page/login_page.dart';

void main() {
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const LoginPage(),
    );
  }
}
