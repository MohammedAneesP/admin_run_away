
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';

class TheTextField extends StatelessWidget {
  const TheTextField({
    super.key,
    required this.anLabelText,
    required this.forMaxLine,
    required this.anController,
    required this.anType,
  });
  final String anLabelText;
  final int? forMaxLine;
  final TextInputType anType;
  final TextEditingController anController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: anController,
      textAlign: TextAlign.start,
      maxLines: forMaxLine,
      keyboardType: anType,
      decoration: InputDecoration(
        filled: true,
        fillColor: kGrey.withOpacity(0.1),
        label: Text(anLabelText),
        disabledBorder: InputBorder.none,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
      ),
    );
  }
}
