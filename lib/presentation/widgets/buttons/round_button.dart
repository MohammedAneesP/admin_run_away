import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';

class SizeButton extends StatefulWidget {
  const SizeButton({super.key, required this.anSize, required this.sizeList});
  final int anSize;
  final List<dynamic> sizeList;
  @override
  State<SizeButton> createState() => _SizeButtonState();
}

class _SizeButtonState extends State<SizeButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      width: 62,
      child: OutlinedButton(
        style: ButtonStyle(
          side: const MaterialStatePropertyAll(BorderSide.none),
          elevation: MaterialStateProperty.all(5),
          shadowColor: MaterialStateProperty.all(
            kGrey,
          ),
          shape: const MaterialStatePropertyAll(
            CircleBorder(
              side: BorderSide.none,
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(
              widget.sizeList.contains(widget.anSize)
                  ? kBlue
                  : kWhite),
        ),
        onPressed: () {
          setState(() {
            widget.sizeList.contains(widget.anSize)
                ? widget.sizeList.remove(widget.anSize)
                : widget.sizeList.add(widget.anSize);
          });
        },
        child: Text(
          widget.anSize.toString(),
          style: TextStyle(fontSize: 10,
          
            color: widget.sizeList.contains(widget.anSize)
                ? kWhite
                : kBlue,
          ),
        ),
      ),
    );
  }
}
