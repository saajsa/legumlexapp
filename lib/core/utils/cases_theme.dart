import 'package:flutter/material.dart';

/// Cases Module Theme System
/// Replicates the CSS framework from /cases/assets/css/cases-framework.css
/// Minimalist Black & White Design System
class CasesTheme {
  // Core Colors (from CSS variables)
  static const Color primary = Color(0xFF1A1A1A);
  static const Color primaryHover = Color(0xFF000000);
  static const Color secondary = Color(0xFF666666);
  static const Color textColor = Color(0xFF2C2C2C);
  static const Color textLight = Color(0xFF666666);
  static const Color textMuted = Color(0xFF999999);
  
  // Background Colors
  static const Color bgPrimary = Color(0xFFFFFFFF);
  static const Color bgSecondary = Color(0xFFFAFAFA);
  static const Color bgTertiary = Color(0xFFF8F8F8);
  static const Color bgHover = Color(0xFFFAFAFA);
  
  // Border Colors
  static const Color border = Color(0xFFE1E1E1);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFD1D1D1);
  
  // Status Colors
  static const Color success = Color(0xFF2D7D2D);
  static const Color successBg = Color(0xFFF0F9F0);
  static const Color warning = Color(0xFFCC8C1A);
  static const Color warningBg = Color(0xFFFFF8E6);
  static const Color danger = Color(0xFFCC1A1A);
  static const Color dangerBg = Color(0xFFFFF0F0);
  static const Color info = Color(0xFF1A6BCC);
  static const Color infoBg = Color(0xFFEFF8FF);
  
  // Spacing (converted from CSS rem/px to double)
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 20.0;
  static const double spacingLg = 30.0;
  static const double spacingXl = 40.0;
  
  // Typography (converted from CSS rem to sp)
  static const double fontSizeXs = 10.4; // 0.65rem
  static const double fontSizeSm = 12.0;  // 0.75rem
  static const double fontSizeBase = 14.0; // 0.875rem
  static const double fontSizeLg = 16.0;   // 1rem
  static const double fontSizeXl = 17.6;   // 1.1rem
  static const double fontSize2xl = 19.2;  // 1.2rem
  static const double fontSize3xl = 35.2;  // 2.2rem
  
  // Border Radius
  static const double radius = 2.0;
  static const double cardRadius = 8.0;
  
  // Shadows
  static const BoxShadow shadowSm = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.02),
    blurRadius: 3,
    offset: Offset(0, 1),
  );
  
  static const BoxShadow shadowMd = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.06),
    blurRadius: 8,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow shadowLg = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 20,
    offset: Offset(0, 4),
  );
  
  // Font Family
  static const String fontFamily = 'Inter';
  
  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize3xl,
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: -0.02,
    height: 1.2,
  );
  
  static const TextStyle heading2xl = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize2xl,
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: -0.01,
  );
  
  static const TextStyle headingXl = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeXl,
    fontWeight: FontWeight.w600,
    color: primary,
  );
  
  static const TextStyle headingLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLg,
    fontWeight: FontWeight.w600,
    color: primary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLg,
    fontWeight: FontWeight.w400,
    color: textColor,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeBase,
    fontWeight: FontWeight.w400,
    color: textColor,
    height: 1.4,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeSm,
    fontWeight: FontWeight.w400,
    color: textLight,
    height: 1.3,
  );
  
  static const TextStyle captionLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeSm,
    fontWeight: FontWeight.w500,
    color: textLight,
  );
  
  static const TextStyle captionSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeXs,
    fontWeight: FontWeight.w600,
    color: textMuted,
    letterSpacing: 0.5,
  );
  
  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: spacingLg,
      vertical: spacingMd,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
    textStyle: const TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSizeBase,
      fontWeight: FontWeight.w500,
    ),
  );
  
  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primary,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(
      horizontal: spacingLg,
      vertical: spacingMd,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    side: const BorderSide(color: border, width: 1),
    textStyle: const TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSizeBase,
      fontWeight: FontWeight.w500,
    ),
  );
  
  // Input Decoration
  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: danger, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingSm,
        vertical: spacingMd,
      ),
      filled: true,
      fillColor: bgPrimary,
      labelStyle: bodyMedium.copyWith(color: textLight),
      hintStyle: bodyMedium.copyWith(color: textMuted),
    );
  }
  
  // Card Decoration
  static BoxDecoration cardDecoration({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    Color? leftBorderColor,
    double? leftBorderWidth,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? bgPrimary,
      borderRadius: BorderRadius.circular(cardRadius),
      border: Border.all(
        color: borderColor ?? border,
        width: borderWidth ?? 1,
      ),
      boxShadow: const [shadowSm],
    );
  }
  
  static BoxDecoration cardDecorationWithLeftBorder({
    Color? backgroundColor,
    Color? borderColor,
    required Color leftBorderColor,
    double? leftBorderWidth,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? bgPrimary,
      borderRadius: BorderRadius.circular(cardRadius),
      border: Border(
        left: BorderSide(
          color: leftBorderColor,
          width: leftBorderWidth ?? 3,
        ),
        top: BorderSide(color: borderColor ?? border, width: 1),
        right: BorderSide(color: borderColor ?? border, width: 1),
        bottom: BorderSide(color: borderColor ?? border, width: 1),
      ),
      boxShadow: const [shadowSm],
    );
  }
  
  // Status Colors Helper
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'consultation':
      case 'scheduled':
      case 'active':
        return info;
      case 'litigation':
      case 'completed':
        return success;
      case 'pending':
      case 'adjourned':
        return warning;
      case 'cancelled':
      case 'dismissed':
        return danger;
      case 'inactive':
      case 'on-hold':
      default:
        return textLight;
    }
  }
  
  static Color getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'consultation':
      case 'scheduled':
      case 'active':
        return infoBg;
      case 'litigation':
      case 'completed':
        return successBg;
      case 'pending':
      case 'adjourned':
        return warningBg;
      case 'cancelled':
      case 'dismissed':
        return dangerBg;
      case 'inactive':
      case 'on-hold':
      default:
        return bgTertiary;
    }
  }
  
  // Priority Colors
  static Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return danger;
      case 'medium':
        return warning;
      case 'low':
        return info;
      default:
        return textLight;
    }
  }
  
  static Color getPriorityBackgroundColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerBg;
      case 'medium':
        return warningBg;
      case 'low':
        return infoBg;
      default:
        return bgTertiary;
    }
  }
  
  // Animation Duration
  static const Duration transitionDuration = Duration(milliseconds: 150);
}