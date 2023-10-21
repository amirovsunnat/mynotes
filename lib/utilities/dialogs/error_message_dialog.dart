import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorMessageDialog(BuildContext context) {
  return showGenericCustomDialog(
    context: context,
    title: "Cannot send password reset",
    content: "Please enter your email first.",
    optionsBuilder: () => {
      "OK": null,
    },
  );
}
