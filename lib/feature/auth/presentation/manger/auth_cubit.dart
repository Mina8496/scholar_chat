import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/feature/auth/presentation/manger/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      // UserCredential user =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        emit(
          LoginFailureState(
            errorMessage: 'The email or password is incorrect.',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginFailureState(errorMessage: 'Unable to sign in. Please try again.'),
      );
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          RegisterFailureState(
            errorMessage: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailureState(
            errorMessage: 'The account already exists for that email.',
          ),
        );
      }
    } catch (e) {
      RegisterFailureState(errorMessage: e.toString());
    }
  }
}
