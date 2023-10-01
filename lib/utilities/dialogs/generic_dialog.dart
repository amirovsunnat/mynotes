import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericCustomDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.indigo, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text(title),
        contentTextStyle: GoogleFonts.poppins(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              optionTitle,
              style:
                  GoogleFonts.poppins(color: Colors.indigoAccent, fontSize: 16),
            ),
          );
        }).toList(),
      );
    },
  );
}
