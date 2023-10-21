import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/helpers/loading/loading_screen.dart';
import 'package:mynotes/screens/notes/create_update_note.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/screens/auth_screen.dart';
import 'package:mynotes/screens/email_verification_screen.dart';
import 'package:mynotes/screens/notes/notes_screen.dart';
import 'package:mynotes/screens/send_password_reset_email_screen.dart';
import 'package:mynotes/services/auth/bloc/auht_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/services/auth/firebase_auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 7, 15, 255),
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.indigo,
            ),
      ),
      home: AnimatedSplashScreen(animationDuration: const Duration(seconds: 3),
      splash: 'assets/icon/icon.png',
      nextScreen: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FireBaseAuthProvider()),
        child: const HomePage(),
      ),
      splashTransition: SplashTransition.rotationTransition,
      splashIconSize: 120,
      
    ),
         routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteScreen(),
      },
      ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading){
          LoadingScreen().show(context: context, text: state.loadingText ?? "Please wait a moment",);
        }else{
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesScreen();
        } else if (state is AuthStateNeedsEmailVerification) {
          return const EmailVerificationScreen();
        } else if (state is AuthStateLoggedOut) {
          return const AuthenticationScreen();
        } else if (state is AuthStateRegistering) {
          return const AuthenticationScreen();
        
        } else if (state is AuthStateForgotPassword){
          return const SendPasswordResetEmailScreen();
        }
        else {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
