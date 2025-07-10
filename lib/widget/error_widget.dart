import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Please try again later',
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}
