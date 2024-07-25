import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final int? maxLength;
  const CommonTextField({
    super.key,
    this.hintText,
    this.controller,
    this.textInputType,
    this.maxLength,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFfcfefd),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        //  border: Border.all(color: Color(0xFFd8e9fa), width: 1)
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textInputType ?? TextInputType.text,
        maxLength: widget.maxLength,
        maxLines: 1,
        decoration: InputDecoration(
            counterText: '',
            hintText: widget.hintText,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
           contentPadding: EdgeInsets.only(left: 10,)
        ),

      ),
    );
  }
}
