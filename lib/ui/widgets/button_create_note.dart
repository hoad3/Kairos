


import 'package:flutter/material.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:kairos/ui/widgets/noteScreen.dart';

class ButtonCreateNote extends StatefulWidget {
  final String label;
  final Function()? onTap;
  const ButtonCreateNote({super.key , required this.label, required this.onTap});

  @override
  State<ButtonCreateNote> createState() => _ButtonCreateNoteState();
}

class _ButtonCreateNoteState extends State<ButtonCreateNote> {
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
