import 'package:flutter/material.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Spacer(flex: 1),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'pacifico',
              ),
            ),
            Spacer(flex: 1),
            Row(
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(hintText: 'email'),
            const SizedBox(height: 10),

            CustomTextField(hintText: 'password'),
            const SizedBox(height: 20),
 
            CustomButton(text: 'login', onPressed: () {}),
            Row(
              children: [
                Text(
                  "don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
