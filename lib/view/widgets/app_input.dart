import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    required this.label,
    this.obscure = false,
    required this.onchanged,
    required this.controller,
    this.validator,
  }) : super(key: key);
  final String label;
  final Function(String) onchanged;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: obscure,
          onChanged: onchanged,
          controller: controller,
          validator: validator,
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
            errorStyle: TextStyle(
              fontFamily: 'Montserrat',
            ),
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
