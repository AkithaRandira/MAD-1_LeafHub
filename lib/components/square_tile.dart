import 'package:flutter/material.dart';

class SqaureTile extends StatelessWidget {
  final String imagePath;
  const SqaureTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFCFEED8),
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
