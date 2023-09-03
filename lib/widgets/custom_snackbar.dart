import 'package:flutter/material.dart';

class CustomGradientSnackbar {
  final String text;
  final Gradient? gradient;
  final Color? textColor;

  CustomGradientSnackbar({
    required this.text,
    this.gradient,
    this.textColor,
  });

  void show(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: 3,
        left: 0,
        right: 0,
        child: Material(
          elevation: 6.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.deepOrange,
                  Color.fromARGB(255, 243, 223, 42),
                ],
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2)).then((_) {
      overlayEntry.remove();
    });
  }
}
