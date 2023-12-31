import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mynotes/services/auth/bloc/auht_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Email Verification",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventLogOut());
          },
          icon: const Icon(Icons.arrow_back_outlined, size: 20,),
        ),
      ),
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
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/images/verify_email_animation.json",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "We have sent you email verification link. Please verify your email.",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "If you did not get the link. You can send it here.",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Lottie.asset("assets/images/animated_arrow.json",
                        height: 80),
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
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(const AuthEventSendEmailVerification());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          "Send Verification",
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
