import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat/feature/auth/presentation/manger/cubit/auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>(((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          // UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
            LoginFailureState(
              errorMessage: 'Unable to sign in. Please try again.',
            ),
          );
        }
      } else if (event is RegisterEvent) {}
    }));
  }
}
