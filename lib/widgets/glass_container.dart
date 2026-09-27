import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlassContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final double blur;
  final Color? borderColor;
  final Gradient? glassGradient;
  final bool enableHoverEffect;
  final VoidCallback? onTap;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(24),
    this.margin = EdgeInsets.zero,
    this.borderRadius = 20,
    this.blur = 18,
    this.borderColor,
    this.glassGradient,
    this.enableHoverEffect = true,
    this.onTap,
  });

  @override
  State<LiquidGlassContainer> createState() => _LiquidGlassContainerState();
}

class _LiquidGlassContainerState extends State<LiquidGlassContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = widget.borderColor ??
        (_isHovered
            ? const Color(0xFF00E5FF).withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.15));

    final effectiveGradient = widget.glassGradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: _isHovered ? 0.12 : 0.07),
            Colors.white.withValues(alpha: _isHovered ? 0.05 : 0.02),
          ],
        );

    Widget containerContent = Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: effectiveBorderColor,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: _isHovered ? 30 : 20,
            offset: const Offset(0, 10),
            spreadRadius: -2,
          ),
          if (_isHovered)
            BoxShadow(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
              blurRadius: 25,
              spreadRadius: 2,
            ),
        ],
      ),
      child: widget.child,
    );

    Widget glassWidget = Container(
      margin: widget.margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blur,
            sigmaY: widget.blur,
          ),
          child: containerContent,
        ),
      ),
    );

    if (widget.onTap != null) {
      glassWidget = GestureDetector(
        onTap: widget.onTap,
        child: glassWidget,
      );
    }

    if (!widget.enableHoverEffect) {
      return glassWidget;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: glassWidget,
      ),
    );
  }
}
