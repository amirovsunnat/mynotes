import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/screens/auth_screen.dart';
import 'package:mynotes/screens/email_verification_screen.dart';
import 'package:mynotes/screens/notes_screen.dart';

import 'firebase_options.dart';

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
        "/authentication/": (context) => const AuthenticationScreen(),
        "/emailverification/": (context) => const EmailVerificationScreen(),
        "/tasks/": (context) => const NotesScreen(),
      },
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesScreen();
              }
            }
            return const AuthenticationScreen();
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.indigoAccent),
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
