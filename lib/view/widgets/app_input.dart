import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    required this.label,
    this.obscure = false,
    required this.onchanged, required this.controller,
  }) : super(key: key);
  final String label;
  final Function(String) onchanged;
  final bool obscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          obscureText: obscure,
          onChanged: onchanged,
          controller: controller,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            hintText: label,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
          ),
        ),
      ],
    );
  }
}
