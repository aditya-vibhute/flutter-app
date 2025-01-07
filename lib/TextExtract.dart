
import 'package:flutter/material.dart';

class TextExtracted extends StatelessWidget {
  const TextExtracted({super.key});

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    );
  }
}
