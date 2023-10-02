import 'package:flutter/material.dart';

class ManagementBox extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  ManagementBox({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 360,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF10DA24),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
