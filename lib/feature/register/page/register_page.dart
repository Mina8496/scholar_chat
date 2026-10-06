import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/routes/app_navigator.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Spacer(flex: 1),
            Image.asset('assets/images/scholar.png', width: 100),
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
                  'Register',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(hintText: 'email'),
            const SizedBox(height: 10),

            CustomTextField(hintText: 'password'),
            const SizedBox(height: 20),

            CustomButton(text: 'Register', onPressed: () {}),
            Row(
              children: [
                Text(
                  "Already have an account..?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () => AppNavigator.pop(context),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
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
