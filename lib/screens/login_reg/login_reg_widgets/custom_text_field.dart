import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int lines;
  final double containerHeight;
  final TextInputType keyBoardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
    this.lines = 1,
    this.containerHeight = 50,
    this.keyBoardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Container(
        height: containerHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 233, 233, 233),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: TextFormField(
              keyboardType: keyBoardType,
              maxLines: lines,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
              onChanged: onChanged,
              validator: validator,
              obscureText: obscureText,
            ),
          ),
        ),
      ),
    );
  }
}
