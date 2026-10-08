import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/routes/app_navigator.dart';
import 'package:scholar_chat/core/helper/app_snackbar.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';
import 'package:scholar_chat/feature/chat_page/page/chat_page.dart';
import 'package:scholar_chat/feature/register/page/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> fromKey = GlobalKey();
  bool isLoading = true;

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
                          'LOGIN',
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
                      text: 'login',
                      onPressed: () async {
                        if (fromKey.currentState!.validate()) {
                          isLoading = false;
                          setState(() {});
                          try {
                            await loginUser();
                            if (mounted) {
                              AppSnackBar.success(context, 'success.');
                            }
                            AppNavigator.push(context, ChatPage());
                          } on FirebaseAuthException catch (e) {
                            if (!mounted) return;
                            if (e.code == 'user-not-found' ||
                                e.code == 'wrong-password' ||
                                e.code == 'invalid-credential') {
                              AppSnackBar.info(
                                context,
                                'The email or password is incorrect.',
                              );
                            } else {
                              AppSnackBar.error(
                                context,
                                'Unable to sign in. Please try again.',
                              );
                            }
                          } catch (_) {
                            if (mounted) {
                              AppSnackBar.error(
                                context,
                                'Unable to sign in. Please try again.',
                              );
                            }
                          } finally {
                            if (mounted) {
                              isLoading = true;
                              setState(() {});
                            }
                          }
                        }
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () =>
                              AppNavigator.push(context, RegisterPage()),
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
