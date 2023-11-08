import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final String currency;

  const CurrencyText({Key? key, required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: currency,
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}