import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kairos/ui/Calendar/themes.dart';

class ButtonCreate1 extends StatefulWidget {
  final String label;
  final Function()? onTap;
  const ButtonCreate1({Key? key, required this.label, required this.onTap});

  @override
  State<ButtonCreate1> createState() => _Button_Created();
}

class _Button_Created extends State<ButtonCreate1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: 90,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Button_1
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )

      ),
    );
  }
}


