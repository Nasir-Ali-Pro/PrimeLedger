import 'dart:io';
import 'package:flutter/material.dart';

class AppErrorHandler {
  /// Converts any dynamic exception or error object into a clean, human-readable user-friendly message.
  static String getFriendlyMessage(dynamic error) {
    if (error == null) return 'An unexpected error occurred. Please try again.';

    final errorStr = error.toString();

    // Database foreign key or dependency constraint
    if (errorStr.contains('FOREIGN KEY') || errorStr.contains('787') || errorStr.contains('constraint failed')) {
      return 'Cannot delete or modify this item because it is linked to active invoices, payments, or transaction records.';
    }

    // Database locked or busy
    if (errorStr.contains('database is locked') || errorStr.contains('SqliteException(5)')) {
      return 'Database is currently busy. Please try again in a moment.';
    }

    // Format or number parsing exceptions
    if (error is FormatException || errorStr.contains('FormatException')) {
      return 'Invalid number format entered. Please verify all amount and quantity fields.';
    }

    // File system / Storage issues
    if (error is FileSystemException || errorStr.contains('FileSystemException') || errorStr.contains('Permission denied')) {
      return 'Storage error. Please check storage permissions or free space on your device.';
    }

    // Inventory / Stock issues
    if (errorStr.toLowerCase().contains('stock') || errorStr.toLowerCase().contains('inventory')) {
      return 'Insufficient product stock available for this operation.';
    }

    // Clean up generic Exception: prefixes
    String cleanMsg = errorStr;
    if (cleanMsg.startsWith('Exception: ')) {
      cleanMsg = cleanMsg.substring(11);
    } else if (cleanMsg.startsWith('StateError: ')) {
      cleanMsg = cleanMsg.substring(12);
    }

    if (cleanMsg.trim().isEmpty) {
      return 'An unexpected error occurred. Please try again.';
    }

    return cleanMsg;
  }

  /// Displays a standardized red error SnackBar with a clean user-friendly error message.
  static void showErrorSnackBar(BuildContext context, dynamic error, {String prefix = ''}) {
    final message = getFriendlyMessage(error);
    final displayText = prefix.isNotEmpty ? '$prefix: $message' : message;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Displays a standardized green success SnackBar.
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
