import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/core/helper/app_snackbar.dart';
import 'package:scholar_chat/feature/auth/presentation/manger/bloc/auth_bloc.dart';
import 'package:scholar_chat/feature/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:scholar_chat/feature/chat_page/manger/chat_cubit.dart';
import 'package:scholar_chat/feature/auth/presentation/page/login/page/login_page.dart';
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
        // BlocProvider(create: (context) => LoginCubit()),
        // BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],

      child: MaterialApp(
        scaffoldMessengerKey: AppSnackBar.messengerKey,
        home: LoginPage(),
      ),
    );
  }
}
