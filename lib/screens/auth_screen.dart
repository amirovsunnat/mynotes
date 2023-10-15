import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auht_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';

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

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  Color _emailIconColor = Colors.grey;
  Color _passwordIconColor = Colors.grey;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    _emailFocus.addListener(
      () {
        setState(
          () {
            if (_emailFocus.hasFocus) {
              _emailIconColor = Colors.indigo;
            } else {
              _emailIconColor = Colors.grey;
            }
          },
        );
      },
    );
    _passwordFocus.addListener(
      () {
        setState(
          () {
            if (_passwordFocus.hasFocus) {
              _passwordIconColor = Colors.indigo;
            } else {
              _passwordIconColor = Colors.grey;
            }
          },
        );
      },
    );
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            Flushbar(
              message: "Cannot find a user with the entered credentials.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is WrongPasswordAuthException) {
            Flushbar(
              message:
                  "Wrong password or email. Please check your password or email and try again",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is InvalidEmailAuthException) {
            Flushbar(
              message: "Please enter valid email address",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is TooManyRequestsAuthException) {
            Flushbar(
              message: "Too many sign-in attempts. Please try again later.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is UserDisabledAuthException) {
            Flushbar(
              message: "User account is disabled.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is ChannelErrorAuthException) {
            Flushbar(
              message: "Please fill the email and password fields.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is GenericAuthExceptions) {
            Flushbar(
              message: "Authentication error.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          }
        }
        if (state is AuthStateRegistering) {
          if (state.exception is InvalidEmailAuthException) {
            Flushbar(
              message: "Please enter a valid email address.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            Flushbar(
              message: "Email address is already in use.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is TooManyRequestsAuthException) {
            Flushbar(
              message: "Too many sign-up attempts. Please try again later.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is WeakPasswordAuthException) {
            Flushbar(
              message:
                  "Password must be at least 6 characters long. Please choose a stronger password",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is ChannelErrorAuthException) {
            Flushbar(
              message: "Please fill the email and password fields.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          } else if (state.exception is GenericAuthExceptions) {
            Flushbar(
              message: "Authentication error.",
              duration: const Duration(seconds: 3),
              messageColor: Colors.white,
              backgroundColor: Colors.indigo,
            ).show(context);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(gradient: LinearGradient(
  begin: AlignmentDirectional.centerStart,
  end: Alignment.centerRight,
  colors: [
    Color.fromRGBO(29, 45, 68, 1),  // A deep navy blue
    Color.fromRGBO(43, 79, 121, 1), // A vibrant blue
    Color.fromRGBO(86, 132, 186, 1), // A lighter blue
    Color.fromRGBO(43, 79, 121, 1), // A vibrant blue (repeated)
    Color.fromRGBO(29, 45, 68, 1),  // A deep navy blue (repeated)
  ],
),
),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/icon/icon.png", height: 50, color: Colors.white,),
                            const SizedBox(
                              width: 20,
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
                          height: 50,
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 60),
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
                                        offset: const Offset(
                                            0, 2), // Adjust the shadow offset
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    focusNode: _emailFocus,
                                    controller: _email,
                                    cursorColor: Colors.black,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.email_outlined,
                                        color: _emailIconColor,
                                      ),
                                      hintText: "  name@gmail.com",
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors
                                            .grey, // Set the hint text color
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.indigo),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
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
                                        offset: const Offset(
                                            0, 2), // Adjust the shadow offset
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    focusNode: _passwordFocus,
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
                                            color: _passwordIconColor),
                                      ),
                                      hintText: "  ****************",
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors
                                            .grey, // Set the hint text color
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.indigo),
                                      ),
                                      border: InputBorder.none, //
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                                if (_isLogin)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          context.read<AuthBloc>().add(const AuthEventForgotPassword(email: ""));
                                        },
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      gradient: LinearGradient(
  begin: AlignmentDirectional.centerStart,
  end: Alignment.centerRight,
  colors: [
    Color.fromRGBO(29, 45, 68, 1),  // A deep navy blue
    Color.fromRGBO(43, 79, 121, 1), // A vibrant blue
    Color.fromRGBO(86, 132, 186, 1), // A lighter blue
    Color.fromRGBO(43, 79, 121, 1), // A vibrant blue (repeated)
    Color.fromRGBO(29, 45, 68, 1),  // A deep navy blue (repeated)
  ],
)


                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final email = _email.text.trim();
                                        final password = _password.text.trim();
                                        context.read<AuthBloc>().add(
                                              AuthEventLogIn(
                                                email,
                                                password,
                                              ),
                                            );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      gradient: LinearGradient(
  begin: AlignmentDirectional.centerStart,
  end: Alignment.centerRight,
  colors: [
    Color.fromRGBO(29, 45, 68, 1),  // A deep navy blue
    Color.fromRGBO(43, 79, 121, 1), // A vibrant blue
    Color.fromRGBO(86, 132, 186, 1), // A lighter blue
    Color.fromRGBO(43, 79, 121, 1), // A vibrant blue (repeated)
    Color.fromRGBO(29, 45, 68, 1),  // A deep navy blue (repeated)
  ],
)

                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final email = _email.text.trim();
                                        final password = _password.text.trim();
                                        context.read<AuthBloc>().add(
                                              AuthEventRegister(
                                                email,
                                                password,
                                              ),
                                            );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
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
                                            fontSize: 14, color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: _isLogin
                                                ? 'Sign Up'
                                                : "Sign In",
                                            style: GoogleFonts.poppins(
                                              color: const Color.fromRGBO(43, 79, 121, 1),
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
                                          onTap: () {},
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
        ),
      ),
    );
  }
}

Future<bool> showVerificationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Verify your email",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Please verify your email address to continue.",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(true);
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text(
                "Go to verification screen",
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 0, 227),
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    ),
  ).then((value) => value ?? false);
}
