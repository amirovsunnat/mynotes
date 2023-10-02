import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/screens/notes/create_update_note.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/screens/auth_screen.dart';
import 'package:mynotes/screens/email_verification_screen.dart';
import 'package:mynotes/screens/notes/notes_screen.dart';
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
              secondary: const Color.fromARGB(255, 5, 255, 13),
            ),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FireBaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        authenticationRoute: (context) => const AuthenticationScreen(),
        emailVerificationRoute: (context) => const EmailVerificationScreen(),
        notesRoute: (context) => const NotesScreen(),
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesScreen();
        } else if (state is AuthStateNeedsEmailVerification) {
          return const EmailVerificationScreen();
        } else if (state is AuthStateLoggedOut) {
          return const AuthenticationScreen();
        } else {
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
