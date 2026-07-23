import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color indigo = Color(0xFF6366F1);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color emerald = Color(0xFF10B981);
  static const Color amber = Color(0xFFF59E0B);
  static const Color rose = Color(0xFFEF4444);
  static const Color teal = Color(0xFF14B8A6);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: indigo,
        brightness: Brightness.light,
        primary: indigo,
        secondary: purple,
        surface: Colors.white,
        error: rose,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: const Color(0xFF111827)),
        displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: const Color(0xFF111827)),
        titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: const Color(0xFF111827)),
        bodyLarge: GoogleFonts.inter(color: const Color(0xFF374151)),
        bodyMedium: GoogleFonts.inter(color: const Color(0xFF4B5563)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color(0xFF111827)),
        titleTextStyle: GoogleFonts.outfit(
          color: const Color(0xFF111827),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        color: Colors.white,
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: indigo,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: indigo,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: indigo, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.white,
        useIndicator: true,
        indicatorColor: indigo.withValues(alpha: 0.12),
        selectedIconTheme: const IconThemeData(color: indigo),
        unselectedIconTheme: const IconThemeData(color: Color(0xFF9CA3AF)),
        selectedLabelTextStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, color: indigo, fontSize: 12),
        unselectedLabelTextStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFE5E7EB), thickness: 1),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF1F2937),
        contentTextStyle: GoogleFonts.inter(color: Colors.white),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20, color: const Color(0xFF111827)),
        contentTextStyle: GoogleFonts.inter(color: const Color(0xFF4B5563), fontSize: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF3F4F6),
        selectedColor: indigo.withValues(alpha: 0.12),
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: indigo.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: indigo);
          }
          return GoogleFonts.inter(fontSize: 12, color: const Color(0xFF9CA3AF));
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: indigo, size: 24);
          }
          return const IconThemeData(color: Color(0xFF9CA3AF), size: 24);
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: indigo,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: indigo,
          side: BorderSide(color: indigo.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: indigo,
        brightness: Brightness.dark,
        primary: indigo,
        secondary: purple,
        surface: const Color(0xFF1F2937),
        error: rose,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF111827),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.inter(color: const Color(0xFFD1D5DB)),
        bodyMedium: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF374151), width: 1),
        ),
        color: const Color(0xFF1F2937),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: indigo,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: indigo,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1F2937),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF374151)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF374151)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: indigo, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: const Color(0xFF1F2937),
        useIndicator: true,
        indicatorColor: indigo.withValues(alpha: 0.2),
        selectedIconTheme: const IconThemeData(color: indigo),
        unselectedIconTheme: const IconThemeData(color: Color(0xFF6B7280)),
        selectedLabelTextStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, color: indigo, fontSize: 12),
        unselectedLabelTextStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFF374151), thickness: 1),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF374151),
        contentTextStyle: GoogleFonts.inter(color: Colors.white),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFF1F2937),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        contentTextStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF374151),
        selectedColor: indigo.withValues(alpha: 0.2),
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1F2937),
        surfaceTintColor: Colors.transparent,
        indicatorColor: indigo.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: indigo);
          }
          return GoogleFonts.inter(fontSize: 12, color: const Color(0xFF6B7280));
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: indigo, size: 24);
          }
          return const IconThemeData(color: Color(0xFF6B7280), size: 24);
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: indigo,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: indigo,
          side: BorderSide(color: indigo.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF1F2937),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }
}
