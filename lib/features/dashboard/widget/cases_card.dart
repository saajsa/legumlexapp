import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/cases_theme.dart';

/// Cases-themed Card Component
/// Replicates .cases-card, .cases-dashboard-card, and .cases-info-card from CSS
class CasesCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? child;
  final List<Widget>? actions;
  final List<CasesCardMetaItem>? metaItems;
  final VoidCallback? onTap;
  final bool isClickable;
  final CasesCardType type;
  final Color? leftBorderColor;
  final bool showHover;

  const CasesCard({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.actions,
    this.metaItems,
    this.onTap,
    this.isClickable = false,
    this.type = CasesCardType.standard,
    this.leftBorderColor,
    this.showHover = true,
  });

  /// Dashboard Card - enhanced styling with hover effects
  const CasesCard.dashboard({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.actions,
    this.metaItems,
    this.onTap,
    this.leftBorderColor,
  }) : isClickable = true,
       type = CasesCardType.dashboard,
       showHover = true;

  /// Info Card - for detailed case information
  const CasesCard.info({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
    this.actions,
    this.metaItems,
    this.onTap,
  }) : isClickable = false,
       type = CasesCardType.info,
       showHover = false,
       leftBorderColor = null;

  /// Stat Card - for statistics display
  const CasesCard.stat({
    super.key,
    this.title,
    this.child,
    this.onTap,
  }) : subtitle = null,
       actions = null,
       metaItems = null,
       isClickable = true,
       type = CasesCardType.stat,
       showHover = true,
       leftBorderColor = null;

  /// Compact Card - smaller padding
  const CasesCard.compact({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.actions,
    this.metaItems,
    this.onTap,
    this.isClickable = false,
    this.leftBorderColor,
  }) : type = CasesCardType.compact,
       showHover = false;

  @override
  Widget build(BuildContext context) {
    final cardContent = _buildCardContent();
    
    return AnimatedContainer(
      duration: CasesTheme.transitionDuration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isClickable ? onTap : null,
          borderRadius: BorderRadius.circular(CasesTheme.cardRadius),
          child: Container(
            decoration: _getCardDecoration(),
            child: cardContent,
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    final padding = _getPadding();
    
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || actions != null) _buildHeader(),
          if (subtitle != null) _buildSubtitle(),
          if (metaItems != null && metaItems!.isNotEmpty) _buildMetaGrid(),
          if (child != null) ...[
            if (title != null || subtitle != null || (metaItems?.isNotEmpty ?? false))
              const SizedBox(height: CasesTheme.spacingMd),
            Flexible(child: child!),
          ],
          if (actions != null && actions!.isNotEmpty) _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(
        bottom: title != null && (child != null || (metaItems?.isNotEmpty ?? false))
            ? CasesTheme.spacingMd
            : 0,
      ),
      padding: EdgeInsets.only(
        bottom: title != null && (child != null || (metaItems?.isNotEmpty ?? false))
            ? 15
            : 0,
      ),
      decoration: BoxDecoration(
        border: title != null && (child != null || (metaItems?.isNotEmpty ?? false))
            ? const Border(
                bottom: BorderSide(
                  color: CasesTheme.borderLight,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: type == CasesCardType.info
                    ? CasesTheme.headingXl
                    : CasesTheme.headingLg,
              ),
            ),
          if (actions != null && actions!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: CasesTheme.spacingSm),
      child: Text(
        subtitle!,
        style: CasesTheme.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMetaGrid() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 600 ? 2 : 1,
              crossAxisSpacing: CasesTheme.spacingSm,
              mainAxisSpacing: CasesTheme.spacingSm,
              childAspectRatio: 4,
            ),
            itemCount: metaItems!.length,
            itemBuilder: (context, index) {
              final item = metaItems![index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item.label,
                      style: CasesTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: CasesTheme.spacingXs),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.value,
                      style: CasesTheme.bodySmall.copyWith(
                        color: CasesTheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: CasesTheme.spacingMd),
      padding: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CasesTheme.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Wrap(
        spacing: CasesTheme.spacingXs,
        runSpacing: CasesTheme.spacingXs,
        children: actions!,
      ),
    );
  }

  BoxDecoration _getCardDecoration() {
    switch (type) {
      case CasesCardType.dashboard:
        return CasesTheme.cardDecoration().copyWith(
          boxShadow: showHover ? [CasesTheme.shadowMd] : [CasesTheme.shadowSm],
        );
      case CasesCardType.info:
        return CasesTheme.cardDecoration();
      case CasesCardType.stat:
        return CasesTheme.cardDecoration();
      case CasesCardType.standard:
      case CasesCardType.compact:
        if (leftBorderColor != null) {
          return CasesTheme.cardDecorationWithLeftBorder(
            leftBorderColor: leftBorderColor!,
          );
        }
        return CasesTheme.cardDecoration();
    }
  }

  EdgeInsets _getPadding() {
    switch (type) {
      case CasesCardType.compact:
        return const EdgeInsets.all(15);
      case CasesCardType.stat:
        return const EdgeInsets.all(CasesTheme.spacingLg);
      case CasesCardType.dashboard:
      case CasesCardType.info:
      case CasesCardType.standard:
        return const EdgeInsets.all(25);
    }
  }
}

/// Card meta information item
class CasesCardMetaItem {
  final String label;
  final String value;

  const CasesCardMetaItem({
    required this.label,
    required this.value,
  });
}

/// Types of cases cards matching CSS classes
enum CasesCardType {
  standard,  // .cases-card
  dashboard, // .cases-dashboard-card
  info,      // .cases-info-card
  stat,      // .cases-stat-card
  compact,   // .cases-card-compact
}