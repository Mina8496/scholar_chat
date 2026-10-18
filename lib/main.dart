import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/core/helper/app_snackbar.dart';
import 'package:scholar_chat/feature/login/manger/login_cubit.dart';
import 'package:scholar_chat/feature/login/page/login_page.dart';
import 'package:scholar_chat/feature/register/manger/register_cubit.dart';
import 'package:scholar_chat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],

      child: MaterialApp(
        scaffoldMessengerKey: AppSnackBar.messengerKey,
        home: LoginPage(),
      ),
    );
  }
}
