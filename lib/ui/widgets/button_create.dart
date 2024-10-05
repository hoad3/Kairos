

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kairos/ui/Calendar/themes.dart';

class Button_Create_Event extends StatefulWidget {
  final String label;
  final Function()? onTap;
  const Button_Create_Event({Key? key, required this.label, required this.onTap});



  @override
  State<Button_Create_Event> createState() => _Button_Create_EventState();
}

class _Button_Create_EventState extends State<Button_Create_Event> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 90,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr
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

