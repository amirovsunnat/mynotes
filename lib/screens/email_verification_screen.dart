import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmailVerifictionScreen extends StatefulWidget {
  const EmailVerifictionScreen({super.key});

  @override
  State<EmailVerifictionScreen> createState() => _EmailVerifictionScreenState();
}

class _EmailVerifictionScreenState extends State<EmailVerifictionScreen> {
  bool _isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orangeAccent,
                  Color.fromARGB(197, 255, 230, 0),
                ], // Define your gradient colors
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/images/verify_email_animation.json",
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        _isEmailVerified
                            ? "You verified your email. You can log in to your account"
                            : "Verify your email",
                        style: GoogleFonts.poppins(
                            fontSize: 24, color: Colors.white),
                      ),
                    ),
                    Lottie.asset("assets/images/animated_arrow.json",
                        height: 150),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepOrange,
                            Colors.yellow,
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;

                          await user!.sendEmailVerification();
                          if (user.emailVerified) {
                            setState(() {
                              _isEmailVerified = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          _isEmailVerified ? "Sign In" : "Send Verifacation",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
