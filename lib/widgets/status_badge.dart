import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final double fontSize;
  
  const StatusBadge({super.key, required this.status, this.fontSize = 12});

  Color get _color {
    switch (status) {
      case 'Paid': case 'Completed': case 'Received': case 'Converted':
        return const Color(0xFF10B981);
      case 'Partially Paid': case 'Pending': case 'Sent': case 'Unpaid': case 'Partial':
        return const Color(0xFFF59E0B);
      case 'Overdue': case 'Cancelled':
        return const Color(0xFFEF4444);
      case 'Draft':
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _color,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
