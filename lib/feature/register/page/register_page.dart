import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/routes/app_navigator.dart';
import 'package:scholar_chat/core/helper/app_snackbar.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';
import 'package:scholar_chat/feature/chat_page/page/chat_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = true;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> fromKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: fromKey,
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    Image.asset(kLogo),
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
                    CustomTextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter email address';
                        }
                        if (!value.contains('@')) {
                          return 'invalid email address';
                        }
                        return null;
                      },
                      hintText: 'email',
                    ),
                    const SizedBox(height: 10),

                    CustomTextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'password is too short';
                        }
                        return null;
                      },
                      hintText: 'password',
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      text: 'Register',
                      onPressed: () async {
                        if (fromKey.currentState!.validate()) {
                          isLoading = false;
                          setState(() {});
                          try {
                            await registerUser();
                            if (mounted) {
                              AppSnackBar.success(context, 'success.');
                            }
                            AppNavigator.push(context, ChatPage(email: emailController.text,));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              AppSnackBar.info(
                                context,
                                'The password provided is too weak.',
                              );
                            } else if (e.code == 'email-already-in-use') {
                              AppSnackBar.error(
                                context,
                                'The account already exists for that email.',
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              AppSnackBar.error(context, e.toString());
                            }
                          }
                          if (mounted) {
                            isLoading = true;
                            setState(() {});
                          }
                        }
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "Already have an account..?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () => AppNavigator.pop(context),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
