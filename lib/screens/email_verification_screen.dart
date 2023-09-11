import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
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
                          fontSize: 24,
                          color: Colors.black,
                        ),
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
                            Colors.indigo,
                            Colors.blue,
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;

                          await user!.sendEmailVerification();
                          await user.reload(); // Reload the user data
                          if (user.emailVerified) {
                            setState(() {
                              _isEmailVerified = true;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          _isEmailVerified ? "Sign In" : "Send Verification",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
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
