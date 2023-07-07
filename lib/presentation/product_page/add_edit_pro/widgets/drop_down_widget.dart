import 'package:flutter/material.dart';

class DropOptionsBrand extends StatelessWidget {
  final Set<String> brandNames;
  String? anOption;
  final ValueChanged<String?>? anOnChange;
  Widget? anHint;
  DropOptionsBrand({
    super.key,
    required this.brandNames,
    required this.anOption,
    required this.anOnChange,
    this.anHint,
  });

 
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: anOption,
      hint: anHint,
      items: brandNames.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: anOnChange,
    );
  }
}
