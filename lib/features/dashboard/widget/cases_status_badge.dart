import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/cases_theme.dart';

/// Cases Status Badge Component
/// Replicates status badge CSS classes from /cases/assets/css/components/status-badges.css
class CasesStatusBadge extends StatelessWidget {
  final String text;
  final CasesStatusType type;
  final CasesBadgeSize size;
  final bool animate;

  const CasesStatusBadge({
    super.key,
    required this.text,
    required this.type,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  });

  /// Status-specific constructors
  const CasesStatusBadge.consultation({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.consultation;

  const CasesStatusBadge.litigation({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.litigation;

  const CasesStatusBadge.active({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.active;

  const CasesStatusBadge.scheduled({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.scheduled;

  const CasesStatusBadge.completed({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.completed;

  const CasesStatusBadge.pending({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.pending;

  const CasesStatusBadge.adjourned({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.adjourned;

  const CasesStatusBadge.cancelled({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.cancelled;

  const CasesStatusBadge.dismissed({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.dismissed;

  const CasesStatusBadge.inactive({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.inactive;

  const CasesStatusBadge.onHold({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
    this.animate = false,
  }) : type = CasesStatusType.onHold;

  @override
  Widget build(BuildContext context) {
    Widget badge = Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        border: Border.all(
          color: _getTextColor(),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(CasesTheme.radius),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: CasesTheme.fontFamily,
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w600,
          color: _getTextColor(),
          letterSpacing: 0.5,
          height: 1.0,
        ),
      ),
    );

    if (animate) {
      return AnimatedContainer(
        duration: const Duration(seconds: 2),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.7, end: 1.0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: badge,
            );
          },
          onEnd: () {
            // Restart animation for pulse effect
          },
        ),
      );
    }

    return badge;
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case CasesBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case CasesBadgeSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CasesTheme.spacingSm,
          vertical: 6,
        );
      case CasesBadgeSize.normal:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
    }
  }

  double _getFontSize() {
    switch (size) {
      case CasesBadgeSize.small:
        return 9.6; // 0.6rem
      case CasesBadgeSize.large:
        return CasesTheme.fontSizeSm;
      case CasesBadgeSize.normal:
        return CasesTheme.fontSizeXs;
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case CasesStatusType.consultation:
      case CasesStatusType.scheduled:
        return CasesTheme.infoBg;
      case CasesStatusType.litigation:
      case CasesStatusType.active:
      case CasesStatusType.completed:
        return CasesTheme.successBg;
      case CasesStatusType.pending:
      case CasesStatusType.adjourned:
        return CasesTheme.warningBg;
      case CasesStatusType.cancelled:
      case CasesStatusType.dismissed:
        return CasesTheme.dangerBg;
      case CasesStatusType.inactive:
      case CasesStatusType.onHold:
        return CasesTheme.bgTertiary;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case CasesStatusType.consultation:
      case CasesStatusType.scheduled:
        return CasesTheme.info;
      case CasesStatusType.litigation:
      case CasesStatusType.active:
      case CasesStatusType.completed:
        return CasesTheme.success;
      case CasesStatusType.pending:
      case CasesStatusType.adjourned:
        return CasesTheme.warning;
      case CasesStatusType.cancelled:
      case CasesStatusType.dismissed:
        return CasesTheme.danger;
      case CasesStatusType.inactive:
      case CasesStatusType.onHold:
        return CasesTheme.textLight;
    }
  }
}

/// Priority Badge Component
class CasesPriorityBadge extends StatelessWidget {
  final String text;
  final CasesPriorityType priority;
  final CasesBadgeSize size;

  const CasesPriorityBadge({
    super.key,
    required this.text,
    required this.priority,
    this.size = CasesBadgeSize.normal,
  });

  const CasesPriorityBadge.high({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
  }) : priority = CasesPriorityType.high;

  const CasesPriorityBadge.medium({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
  }) : priority = CasesPriorityType.medium;

  const CasesPriorityBadge.low({
    super.key,
    required this.text,
    this.size = CasesBadgeSize.normal,
  }) : priority = CasesPriorityType.low;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        border: Border.all(
          color: _getTextColor(),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(CasesTheme.radius),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: CasesTheme.fontFamily,
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w600,
          color: _getTextColor(),
          letterSpacing: 0.5,
          height: 1.0,
        ),
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case CasesBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case CasesBadgeSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CasesTheme.spacingSm,
          vertical: 6,
        );
      case CasesBadgeSize.normal:
        return const EdgeInsets.symmetric(
          horizontal: CasesTheme.spacingXs,
          vertical: 3,
        );
    }
  }

  double _getFontSize() {
    switch (size) {
      case CasesBadgeSize.small:
        return 9.6;
      case CasesBadgeSize.large:
        return CasesTheme.fontSizeSm;
      case CasesBadgeSize.normal:
        return CasesTheme.fontSizeXs;
    }
  }

  Color _getBackgroundColor() {
    switch (priority) {
      case CasesPriorityType.high:
        return CasesTheme.dangerBg;
      case CasesPriorityType.medium:
        return CasesTheme.warningBg;
      case CasesPriorityType.low:
        return CasesTheme.infoBg;
    }
  }

  Color _getTextColor() {
    switch (priority) {
      case CasesPriorityType.high:
        return CasesTheme.danger;
      case CasesPriorityType.medium:
        return CasesTheme.warning;
      case CasesPriorityType.low:
        return CasesTheme.info;
    }
  }
}

/// Count Badge Component
class CasesCountBadge extends StatelessWidget {
  final String count;
  final CasesBadgeSize size;

  const CasesCountBadge({
    super.key,
    required this.count,
    this.size = CasesBadgeSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _getPadding(),
      constraints: const BoxConstraints(minWidth: 20),
      decoration: BoxDecoration(
        color: CasesTheme.bgTertiary,
        border: Border.all(
          color: CasesTheme.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(CasesTheme.radius),
      ),
      child: Text(
        count,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: CasesTheme.fontFamily,
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w600,
          color: CasesTheme.primary,
          height: 1.0,
        ),
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case CasesBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 4, vertical: 2);
      case CasesBadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case CasesBadgeSize.normal:
        return const EdgeInsets.symmetric(
          horizontal: CasesTheme.spacingXs,
          vertical: 2,
        );
    }
  }

  double _getFontSize() {
    switch (size) {
      case CasesBadgeSize.small:
        return 9.6;
      case CasesBadgeSize.large:
        return CasesTheme.fontSizeSm;
      case CasesBadgeSize.normal:
        return CasesTheme.fontSizeXs;
    }
  }
}

/// Notification Badge Component (red circle with count)
class CasesNotificationBadge extends StatelessWidget {
  final String count;
  final Widget child;

  const CasesNotificationBadge({
    super.key,
    required this.count,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: -8,
          right: -8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            constraints: const BoxConstraints(
              minWidth: 18,
              minHeight: 18,
            ),
            decoration: const BoxDecoration(
              color: CasesTheme.danger,
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: CasesTheme.fontFamily,
                fontSize: 9.6, // 0.6rem
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Status Dot Component
class CasesStatusDot extends StatelessWidget {
  final CasesStatusType status;
  final double size;
  final bool animate;

  const CasesStatusDot({
    super.key,
    required this.status,
    this.size = 8.0,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getStatusColor(),
        shape: BoxShape.circle,
      ),
    );

    if (animate) {
      return AnimatedContainer(
        duration: const Duration(seconds: 2),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.5, end: 1.0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: dot,
            );
          },
          onEnd: () {
            // Restart animation for pulse effect
          },
        ),
      );
    }

    return dot;
  }

  Color _getStatusColor() {
    switch (status) {
      case CasesStatusType.active:
      case CasesStatusType.completed:
        return CasesTheme.success;
      case CasesStatusType.pending:
        return CasesTheme.warning;
      case CasesStatusType.inactive:
        return CasesTheme.textMuted;
      case CasesStatusType.cancelled:
        return CasesTheme.danger;
      default:
        return CasesTheme.info;
    }
  }
}

/// Enums for badge types
enum CasesStatusType {
  consultation,
  litigation,
  active,
  scheduled,
  completed,
  adjourned,
  cancelled,
  pending,
  inactive,
  onHold,
  dismissed,
}

enum CasesPriorityType {
  high,
  medium,
  low,
}

enum CasesBadgeSize {
  small,
  normal,
  large,
}