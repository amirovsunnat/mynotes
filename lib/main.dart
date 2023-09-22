import 'package:flutter/material.dart';
import 'package:mynotes/screens/notes/new_note.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/screens/auth_screen.dart';
import 'package:mynotes/screens/email_verification_screen.dart';
import 'package:mynotes/screens/notes/notes_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyNotesApp(),
  );
}

class MyNotesApp extends StatelessWidget {
  const MyNotesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.green,
            ),
      ),
      routes: {
        authenticationRoute: (context) => const AuthenticationScreen(),
        emailVerificationRoute: (context) => const EmailVerificationScreen(),
        notesRoute: (context) => const NotesScreen(),
        newNoteRoute: (context) => const NewNotesScreen(),
      },
      home: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesScreen();
              }
            }
            return const AuthenticationScreen();
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
