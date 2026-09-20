import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;

  const SectionHeader({
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2D63E8), size: 26),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF00265C),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFF00265C),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
