import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/routes/app_navigator.dart';
import 'package:scholar_chat/core/helper/app_snackbar.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';
import 'package:scholar_chat/feature/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:scholar_chat/feature/auth/presentation/manger/cubit/auth_state.dart';
import 'package:scholar_chat/feature/chat_page/manger/chat_cubit.dart';
import 'package:scholar_chat/feature/chat_page/page/chat_page.dart';
import 'package:scholar_chat/feature/auth/presentation/page/register/page/register_page.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> fromKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          AppNavigator.push(context, ChatPage(email: emailController.text));
        } else if (state is LoginFailureState) {
          AppSnackBar.error(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
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
                    obscureText: true,
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
                        BlocProvider.of<AuthCubit>(context).loginUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
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
          ),
        ),
      ),
    );
  }
}
