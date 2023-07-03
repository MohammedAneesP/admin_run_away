

import 'package:flutter/material.dart';

class DropOptionsBrand extends StatefulWidget {
  final Set<String> brandNames;
  String? anOption;
  final ValueChanged<String?>? anOnChange;
  DropOptionsBrand({
    super.key,
    required this.brandNames,
    required this.anOption,
    required this.anOnChange,
  });

  @override
  State<DropOptionsBrand> createState() => _DropOptionsBrandState();
}

class _DropOptionsBrandState extends State<DropOptionsBrand> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.anOption,
      items: widget.brandNames.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.anOnChange,
    );
  }
}
