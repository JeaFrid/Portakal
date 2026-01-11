import 'dart:ui';
import 'package:flutter/material.dart';

class PortakalScroller extends StatefulWidget {
  final Axis scrollDirection;
  final List<Widget> children;

  final bool? reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Clip clipBehavior;
  final String? restorationId;

  const PortakalScroller({
    super.key,
    required this.scrollDirection,
    required this.children,
    this.padding,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.controller,
    this.restorationId,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.reverse = false,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  State<PortakalScroller> createState() => _PortakalScrollerState();
}

class _PortakalScrollerState extends State<PortakalScroller> {
  late ScrollController _localController;

  @override
  void initState() {
    super.initState();
    _localController = widget.controller ?? ScrollController();
  }

  @override
  void didUpdateWidget(covariant PortakalScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _localController.dispose();
      }
      _localController = widget.controller ?? ScrollController();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _localController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
      ),
      child: SingleChildScrollView(
        controller: _localController,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse ?? false,
        padding: widget.padding,
        primary: widget.primary,
        physics: widget.physics,
        restorationId: widget.restorationId,
        clipBehavior: widget.clipBehavior,
        child: widget.scrollDirection == Axis.horizontal
            ? Row(
                mainAxisAlignment:
                    widget.mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                children: widget.children,
              )
            : Column(
                mainAxisAlignment:
                    widget.mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                children: widget.children,
              ),
      ),
    );
  }
}
