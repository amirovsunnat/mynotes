import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/firebase_options.dart';

import 'package:mynotes/services/auth_service.dart';
import 'package:mynotes/widgets/square_tile.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isLogin = true;
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _isPasswordObscured = true;
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Stack(
                children: [
                  Container(
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
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 5, right: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/images/logo.png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'MyNotes',
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Card(
                              margin: const EdgeInsets.only(top: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        _isLogin ? "Sign In" : "Sign Up",
                                        style: GoogleFonts.poppins(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      "Email",
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors
                                            .white, // Set the background color
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey
                                                .withOpacity(0.5), // Add shadow
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                2), // Adjust the shadow offset
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _email,
                                        cursorColor: Colors.black,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Icons.email_outlined,
                                            color: Colors.grey,
                                          ),
                                          hintText: "  name@gmail.com",
                                          hintStyle: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors
                                                .grey, // Set the hint text color
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                        ),
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Password",
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors
                                            .white, // Set the background color
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey
                                                .withOpacity(0.5), // Add shadow
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                2), // Adjust the shadow offset
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _password,
                                        obscureText: _isPasswordObscured,
                                        cursorColor: Colors.black,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isPasswordObscured =
                                                    !_isPasswordObscured; // Toggle password visibility
                                              });
                                            },
                                            child: Icon(
                                              _isPasswordObscured
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          hintText: "  ****************",
                                          hintStyle: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors
                                                .grey, // Set the hint text color
                                          ),
                                          border: InputBorder.none, //
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                        ),
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    if (_isLogin)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Forgot Password?",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: _isLogin ? 20 : 50,
                                    ),
                                    if (_isLogin)
                                      Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.deepOrange,
                                              Colors.yellow,
                                            ],
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final email = _email.text;
                                            final password = _password.text;

                                            final userCredential =
                                                await FirebaseAuth.instance
                                                    .signInWithEmailAndPassword(
                                                        email: email,
                                                        password: password);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent),
                                          child: Text(
                                            "Sign In",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    if (!_isLogin)
                                      Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.deepOrange,
                                              Colors.yellow,
                                            ],
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final email = _email.text;
                                            final password = _password.text;

                                            final userCredential =
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                        email: email,
                                                        password: password);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent),
                                          child: Text(
                                            "Sign Up",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              _isLogin = !_isLogin;
                                            },
                                          );
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: _isLogin
                                                ? "Don't have an account? "
                                                : "Already have an account? ",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: _isLogin
                                                    ? 'Sign Up'
                                                    : "Sign In",
                                                style: GoogleFonts.poppins(
                                                  color: const Color.fromARGB(
                                                      255,
                                                      216,
                                                      72,
                                                      0), // Set your desired text color for "Sign Up"
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "or",
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SquareTile(
                                              onTap: () {
                                                return AuthService()
                                                    .signInWithGoogle();
                                              },
                                              imagePath:
                                                  "assets/images/google.png"),
                                          SquareTile(
                                              onTap: () {},
                                              imagePath:
                                                  "assets/images/apple-logo.png")
                                        ],
                                      ),
                                    ),
                                  ],
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
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
