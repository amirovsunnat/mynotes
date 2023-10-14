import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showSendPasswordResetEmailDialog(BuildContext context) {
  return showGenericCustomDialog(context: context, title: "Password Reset", content: "We have sent you a password reset email. Check your email please.", optionsBuilder: () =>{
    "OK":null,
  });
}