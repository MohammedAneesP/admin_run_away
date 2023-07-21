
import 'package:flutter/material.dart';


class AnEditButton extends StatelessWidget {
  final VoidCallback anOnPressed;

  const AnEditButton({
    super.key,
    required this.anOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: anOnPressed, child: const Text("Edit"));
  }
}
