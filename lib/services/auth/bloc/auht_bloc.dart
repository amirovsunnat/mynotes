import 'package:bloc/bloc.dart';

import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized(isLoading: true)) {
    // send password reset
    on<AuthEventForgotPassword>((event, emit)async{
      emit(const AuthStateForgotPassword(exception: null, hasSentEmail: false, isLoading: false,));
      final email = event.email;
      if (email == null){
        return;  // user wants to go to send-password link screen
      }

      // user need to recieve password change email
      emit(const AuthStateForgotPassword(exception: null, hasSentEmail: false, isLoading: true));
      bool didSentEmail;
      Exception? exception;
      try{
        await provider.sendPasswordReset(toEmail: email);
        didSentEmail = true;
        exception = null;
      } on Exception catch (e){
        didSentEmail = false;
        exception = e;
      }
      emit(AuthStateForgotPassword(exception: exception, hasSentEmail: didSentEmail, isLoading: false,));

    });
    // send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsEmailVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false,));
      }
    });

    // initialize
    on<AuthEventInitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsEmailVerification(isLoading: false));
        } else {
          emit(AuthStateLoggedIn( user: user, isLoading: false,));
        }
      },
    );
    // log in
    on<AuthEventLogIn>(
      (event, emit) async {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: true,
            loadingText: "Please wait a while I log you in",
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.logIn(
            email: email,
            password: password,
          );

          if (!user.isEmailVerified) {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: false,
              ),
            );
            emit(const AuthStateNeedsEmailVerification(isLoading: false,));
          } else {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: false,
              ),
            );
            emit(AuthStateLoggedIn(user:user, isLoading: false,));
          }
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
    // log out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
  }
}
