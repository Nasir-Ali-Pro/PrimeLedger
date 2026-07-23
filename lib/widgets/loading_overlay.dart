import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;

  static void show(BuildContext context, {String message = 'Saving...'}) {
    _overlay = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black54,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  static void hide() {
    _overlay?.remove();
    _overlay = null;
  }
}
