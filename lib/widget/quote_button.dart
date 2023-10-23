import 'package:flutter/material.dart';

class QuoteButton extends StatelessWidget {
  const QuoteButton(
      {super.key,
      required this.icon,
      required this.onPressedButton,
      this.bgColor = Colors.white});

  final Icon icon;
  final Function() onPressedButton;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: onPressedButton,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: bgColor,
          ),
          child: icon,
        ),
      ),
    );
  }
}
