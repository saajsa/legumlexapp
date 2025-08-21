import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/cases_theme.dart';

/// Cases Dashboard Layout Component
/// Replicates dashboard layout patterns from CSS framework
class CasesDashboardLayout extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final String? subtitle;
  final List<Widget>? headerActions;

  const CasesDashboardLayout({
    super.key,
    required this.children,
    this.title,
    this.subtitle,
    this.headerActions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CasesTheme.bgSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) _buildPageHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(CasesTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CasesTheme.spacingXl),
      margin: const EdgeInsets.only(bottom: CasesTheme.spacingLg),
      decoration: CasesTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: CasesTheme.headingLarge,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: CasesTheme.spacingXs),
                      Text(
                        subtitle!,
                        style: CasesTheme.bodyLarge.copyWith(
                          color: CasesTheme.textLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (headerActions != null && headerActions!.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: headerActions!,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Cases Section Header Component
/// Replicates .cases-section-header and .cases-section-with-actions
class CasesSectionHeader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBorder;

  const CasesSectionHeader({
    super.key,
    required this.title,
    this.actions,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: CasesTheme.spacingLg,
      ),
      margin: const EdgeInsets.symmetric(vertical: CasesTheme.spacingMd),
      decoration: CasesTheme.cardDecorationWithLeftBorder(
        leftBorderColor: CasesTheme.primary,
        leftBorderWidth: 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: CasesTheme.heading2xl,
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
}

/// Cases Grid Layout Component
/// Replicates various grid patterns from CSS
class CasesGridLayout extends StatelessWidget {
  final List<Widget> children;
  final CasesGridType type;
  final double? spacing;
  final double? runSpacing;

  const CasesGridLayout({
    super.key,
    required this.children,
    this.type = CasesGridType.responsive,
    this.spacing,
    this.runSpacing,
  });

  const CasesGridLayout.twoColumn({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
  }) : type = CasesGridType.twoColumn;

  const CasesGridLayout.threeColumn({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
  }) : type = CasesGridType.threeColumn;

  const CasesGridLayout.fourColumn({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
  }) : type = CasesGridType.fourColumn;

  const CasesGridLayout.dashboard({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
  }) : type = CasesGridType.dashboard;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = _getColumnCount(constraints.maxWidth);
        final gap = spacing ?? CasesTheme.spacingMd;
        
        if (children.isEmpty) {
          return const SizedBox.shrink();
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: gap,
            mainAxisSpacing: runSpacing ?? gap,
            childAspectRatio: _getChildAspectRatio(),
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }

  int _getColumnCount(double maxWidth) {
    switch (type) {
      case CasesGridType.twoColumn:
        return maxWidth > 768 ? 2 : 1;
      case CasesGridType.threeColumn:
        return maxWidth > 768 ? 3 : (maxWidth > 480 ? 2 : 1);
      case CasesGridType.fourColumn:
        return maxWidth > 768 ? 4 : (maxWidth > 480 ? 2 : 1);
      case CasesGridType.dashboard:
        if (maxWidth > 1200) return 4;
        if (maxWidth > 768) return 3;
        if (maxWidth > 480) return 2;
        return 1;
      case CasesGridType.responsive:
        // Auto-fill with minimum 320px width (like CSS grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)))
        return (maxWidth / 320).floor().clamp(1, 4);
    }
  }

  double _getChildAspectRatio() {
    switch (type) {
      case CasesGridType.dashboard:
        return 1.2; // Dashboard cards are slightly wider than tall
      default:
        return 1.0; // Square by default
    }
  }
}

/// Cases Flex Layout Component
/// Replicates .cases-flex patterns
class CasesFlexLayout extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;
  final bool wrap;
  final double? spacing;
  final double? runSpacing;

  const CasesFlexLayout({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.direction = Axis.horizontal,
    this.wrap = false,
    this.spacing,
    this.runSpacing,
  });

  const CasesFlexLayout.spaceBetween({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.direction = Axis.horizontal,
    this.wrap = false,
    this.spacing,
    this.runSpacing,
  }) : mainAxisAlignment = MainAxisAlignment.spaceBetween;

  const CasesFlexLayout.center({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.wrap = false,
    this.spacing,
    this.runSpacing,
  }) : mainAxisAlignment = MainAxisAlignment.center,
       crossAxisAlignment = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    final gap = spacing ?? CasesTheme.spacingMd;
    
    if (wrap) {
      return Wrap(
        direction: direction,
        spacing: gap,
        runSpacing: runSpacing ?? gap,
        children: children,
      );
    }

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _addSpacing(children, gap, Axis.horizontal),
      );
    } else {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _addSpacing(children, gap, Axis.vertical),
      );
    }
  }

  List<Widget> _addSpacing(List<Widget> children, double gap, Axis axis) {
    if (children.length <= 1) return children;
    
    final List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          axis == Axis.horizontal
              ? SizedBox(width: gap)
              : SizedBox(height: gap),
        );
      }
    }
    return spacedChildren;
  }
}

/// Cases Content Section Component
/// Replicates .cases-content-section
class CasesContentSection extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CasesContentSection({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(CasesTheme.spacingLg),
      margin: margin ?? const EdgeInsets.only(bottom: CasesTheme.spacingLg),
      decoration: CasesTheme.cardDecoration(),
      child: child,
    );
  }
}

/// Cases Empty State Component
/// Replicates .cases-empty-state
class CasesEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget? action;

  const CasesEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CasesTheme.spacingXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: CasesTheme.textMuted.withOpacity(0.5),
          ),
          const SizedBox(height: CasesTheme.spacingMd),
          Text(
            title,
            style: CasesTheme.headingLg.copyWith(
              color: CasesTheme.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CasesTheme.spacingXs),
          Text(
            description,
            style: CasesTheme.bodyMedium.copyWith(
              color: CasesTheme.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            const SizedBox(height: CasesTheme.spacingMd),
            action!,
          ],
        ],
      ),
    );
  }
}

/// Filter Pills Component
/// Replicates .cases-filter-pills
class CasesFilterPills extends StatelessWidget {
  final List<CasesFilterPill> pills;
  final String? selectedPill;
  final ValueChanged<String>? onPillSelected;

  const CasesFilterPills({
    super.key,
    required this.pills,
    this.selectedPill,
    this.onPillSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: pills.map((pill) {
        final isActive = selectedPill == pill.id;
        return GestureDetector(
          onTap: () => onPillSelected?.call(pill.id),
          child: AnimatedContainer(
            duration: CasesTheme.transitionDuration,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isActive ? CasesTheme.primary : CasesTheme.bgPrimary,
              border: Border.all(
                color: isActive ? CasesTheme.primary : CasesTheme.borderDark,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(CasesTheme.radius),
            ),
            child: Text(
              pill.label.toUpperCase(),
              style: CasesTheme.captionLarge.copyWith(
                color: isActive ? Colors.white : CasesTheme.textLight,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Filter Pill Data Model
class CasesFilterPill {
  final String id;
  final String label;

  const CasesFilterPill({
    required this.id,
    required this.label,
  });
}

/// Grid layout types matching CSS patterns
enum CasesGridType {
  twoColumn,    // .cases-grid-2
  threeColumn,  // .cases-grid-3
  fourColumn,   // .cases-grid-4
  responsive,   // .cases-grid-responsive
  dashboard,    // .cases-dashboard-grid
}