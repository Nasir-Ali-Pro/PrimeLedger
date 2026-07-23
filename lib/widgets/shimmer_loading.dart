import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  final int itemCount;
  const ShimmerLoading({super.key, this.itemCount = 5});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);
    final highlightColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F5F5);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: widget.itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [baseColor, highlightColor, baseColor],
                  stops: [
                    (_controller.value - 0.3).clamp(0.0, 1.0),
                    _controller.value,
                    (_controller.value + 0.3).clamp(0.0, 1.0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: highlightColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 14, width: double.infinity, decoration: BoxDecoration(color: highlightColor, borderRadius: BorderRadius.circular(4))),
                        const SizedBox(height: 8),
                        Container(height: 10, width: 120, decoration: BoxDecoration(color: highlightColor, borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(height: 24, width: 60, decoration: BoxDecoration(color: highlightColor, borderRadius: BorderRadius.circular(12))),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
