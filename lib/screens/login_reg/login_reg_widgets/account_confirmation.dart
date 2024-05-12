import 'package:flutter/material.dart';

class AccountConfirmation extends StatelessWidget {
  final String accountConfirmText;
  final VoidCallback onChanged;
  final String loginRegisterText;
  const AccountConfirmation({
    super.key,
    required this.accountConfirmText,
    required this.onChanged,
    required this.loginRegisterText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          accountConfirmText,
        ),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
          onTap: onChanged,
          child: Text(
            loginRegisterText,
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
