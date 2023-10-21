import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/services/auth/bloc/auht_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_message_dialog.dart';
import 'package:mynotes/utilities/dialogs/send_password_reset_email_dialog.dart';

class SendPasswordResetEmailScreen extends StatefulWidget {
  const SendPasswordResetEmailScreen({super.key});

  @override
  State<SendPasswordResetEmailScreen> createState() => _SendPasswordResetEmailScreenState();
}

class _SendPasswordResetEmailScreenState extends State<SendPasswordResetEmailScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: 
    (context, state) async{
      if (state is AuthStateForgotPassword){
        if (state.hasSentEmail){
          _controller.clear();
          await showSendPasswordResetEmailDialog(context);
        }
        if (state.exception.toString() == "firebase_auth/invalid-email"){
          return await showErrorMessageDialog(context);
        //   Flushbar(
        //       message: "Please enter your email first.",
        //       duration: const Duration(seconds: 3),
        //       messageColor: Colors.white,
        //       backgroundColor: Colors.indigo,
        //     ).show(context);
        // } else if (state.exception.toString() == "firebase_auth/user-not-found"){
        //   await showGenericCustomDialog(context: context, title: "Cannot send password reset", content: "Please sign up first.", optionsBuilder: ()=>{
        //     "OK":null,
        //   });
          // Flushbar(
          //     message: "You do not sign up. Please register an account first.",
          //     duration: const Duration(seconds: 3),
          //     messageColor: Colors.white,
          //     backgroundColor: Colors.indigo,
          //   ).show(context);
        }
      }
    },
    child: Scaffold(
  backgroundColor: Colors.blue[40],
      appBar: AppBar( backgroundColor: const Color.fromRGBO(43, 79, 121, 1),
        title: Text("Password Reset", style: GoogleFonts.poppins(), ),
      ),
      body: Padding(padding: const EdgeInsets.only(top: 50, left: 20, right: 20,), child: Column(
        children: [
          Text("Please enter your email address to reset your password.", textAlign: TextAlign.center,style: GoogleFonts.poppins(
            fontSize: 20,
          ),),
          const SizedBox(height: 60),
          TextField(
            cursorColor: const Color.fromRGBO(43, 79, 121, 1),
            controller: _controller,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            decoration: InputDecoration(
                                      suffixIcon: const Icon(
                                        Icons.email_outlined,
                                        color:  Color.fromRGBO(43, 79, 121, 1),
                                      ),
                                      hintText: " enter your email here:",
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
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                                        borderSide:  BorderSide(
                                            color: Colors.grey.withOpacity(0.5)),),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,                                                              ),       
                                    ),
                                    const SizedBox(height: 50,),
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
                                  ),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        final email = _controller.text;
                                        context.read<AuthBloc>().add(AuthEventForgotPassword(email: email,),);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent),
                                      child: Text(
                                        "Send password reset email",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  TextButton(onPressed: (){
                                    context.read<AuthBloc>().add(const AuthEventLogOut());
                                  }, child:  Text("Go back to log in", style: GoogleFonts.poppins(fontSize: 16, color: const Color.fromRGBO(43, 79, 121, 1)),),),
        ],
      ),),
    ),);
  }
}
