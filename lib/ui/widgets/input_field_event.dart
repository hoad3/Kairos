

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:get/get.dart';

class InputFieldEvent extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputFieldEvent({super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget});

  @override
  State<InputFieldEvent> createState() => _InputFieldEventState();
}

class _InputFieldEventState extends State<InputFieldEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      readOnly: widget.widget ==null? false:true,
                      autofocus: false,
                      cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                      controller: widget.controller ?? TextEditingController(),
                      style: subTitleStyle,
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: subTitleStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 0,
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 0,
                        )
                    ),
                  ),
                )
                ),
                widget.widget ==null?Container():Container(child: widget.widget,)
              ],
            ),
          )

        ],
      ),
    );
  }
}
