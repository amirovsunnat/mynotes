import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/screens/auth_screen.dart';
import 'package:mynotes/screens/email_verification_screen.dart';
import 'package:mynotes/screens/tasks_screen.dart';

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
        "/emailverification/": (context) => const EmailVerifictionScreen(),
        "/tasks/": (context) => const TasksScreen(),
      },
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const AuthenticationScreen();
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange,
                    Colors.yellow,
                  ], // Define your gradient colors
                ),
              ),
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
