import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String logRegText;
  final VoidCallback onChanged;
  const CustomElevatedButton({
    super.key,
    required this.logRegText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onChanged,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(
          318,
          46,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      child: Text(
        logRegText,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
