import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const light = _ThemeColors(
    primary: Color(0xFF222671),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD6E6FF),
    onPrimaryContainer: Color(0xFF062B6E),
    secondary: Color(0xFFFF7B54),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFE3D7),
    onSecondaryContainer: Color(0xFF5F1F06),
    background: Color(0xFFF8F9FB),
    onBackground: Color(0xFF111827),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1F2937),
    surfaceVariant: Color(0xFFEFF2F6),
    outline: Color(0xFFD1D5DB),
    border: Color(0xFFE5E7EB),
    muted: Color(0xFF6B7280),
    card: Color(0xFFFFFFFF),
    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    success: Color(0xFF16A34A),
    warning: Color(0xFFF59E0B),
    info: Color(0xFF0EA5E9),
    price: Color(0xFF0F766E),
    discount: Color(0xFFB91C1C),
    rating: Color(0xFFF59E0B),
    inStock: Color(0xFF16A34A),
    outOfStock: Color(0xFF9CA3AF),
    chipBg: Color(0xFFF3F4F6),
  );

  static const dark = _ThemeColors(
    primary: Color(0xFF78A8FF),
    onPrimary: Color(0xFF0A1A3B),
    primaryContainer: Color(0xFF0D224D),
    onPrimaryContainer: Color(0xFFD6E6FF),
    secondary: Color(0xFFFFB89F),
    onSecondary: Color(0xFF3B1203),
    secondaryContainer: Color(0xFF4A1E0E),
    onSecondaryContainer: Color(0xFFFFE3D7),
    background: Color(0xFF0B1020),
    onBackground: Color(0xFFE5E7EB),
    surface: Color(0xFF101527),
    onSurface: Color(0xFFF3F4F6),
    surfaceVariant: Color(0xFF1C2336),
    outline: Color(0xFF3B4153),
    border: Color(0xFF232A3D),
    muted: Color(0xFF9CA3AF),
    card: Color(0xFF131A2E),
    error: Color(0xFFF87171),
    onError: Color(0xFF3B0B0B),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF38BDF8),
    price: Color(0xFF5EEAD4),
    discount: Color(0xFFFCA5A5),
    rating: Color(0xFFFBBF24),
    inStock: Color(0xFF86EFAC),
    outOfStock: Color(0xFF6B7280),
    chipBg: Color(0xFF1F2937),
  );

  static ThemeData getData(bool isDark) {
    final colors = isDark ? dark : light;
    final baseTextTheme = isDark ? Typography.whiteMountainView : Typography.blackMountainView;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        primaryContainer: colors.primaryContainer,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondaryContainer: colors.onSecondaryContainer,
        error: colors.error,
        onError: colors.onError,
        background: colors.background,
        onBackground: colors.onBackground,
        surface: colors.surface,
        onSurface: colors.onSurface,
        outline: colors.outline,
      ),
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.card,
      dividerColor: colors.border,
      textTheme: GoogleFonts.interTextTheme(baseTextTheme).copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: colors.onSurface),
        displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: colors.onSurface),
        displaySmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: colors.onSurface),
        titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: colors.onSurface),
        titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: colors.onSurface),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: colors.onSurface),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: colors.onSurface),
        bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: colors.onSurface),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: colors.onSurface),
      ),
      extensions: [colors],
    );
  }
}

class _ThemeColors extends ThemeExtension<_ThemeColors> {
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color outline;
  final Color border;
  final Color muted;
  final Color card;
  final Color error;
  final Color onError;
  final Color success;
  final Color warning;
  final Color info;
  final Color price;
  final Color discount;
  final Color rating;
  final Color inStock;
  final Color outOfStock;
  final Color chipBg;

  const _ThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.outline,
    required this.border,
    required this.muted,
    required this.card,
    required this.error,
    required this.onError,
    required this.success,
    required this.warning,
    required this.info,
    required this.price,
    required this.discount,
    required this.rating,
    required this.inStock,
    required this.outOfStock,
    required this.chipBg,
  });

  @override
  ThemeExtension<_ThemeColors> copyWith() => this;

  @override
  ThemeExtension<_ThemeColors> lerp(ThemeExtension<_ThemeColors>? other, double t) {
    if (other is! _ThemeColors) return this;
    return _ThemeColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer: Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer: Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      border: Color.lerp(border, other.border, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      card: Color.lerp(card, other.card, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      price: Color.lerp(price, other.price, t)!,
      discount: Color.lerp(discount, other.discount, t)!,
      rating: Color.lerp(rating, other.rating, t)!,
      inStock: Color.lerp(inStock, other.inStock, t)!,
      outOfStock: Color.lerp(outOfStock, other.outOfStock, t)!,
      chipBg: Color.lerp(chipBg, other.chipBg, t)!,
    );
  }
}
