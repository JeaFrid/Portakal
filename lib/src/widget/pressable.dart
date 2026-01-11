import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portakal/portakal.dart';

class PortakalPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scale;
  final Duration duration;
  final int? dismissCount;
  final Duration cooldown;

  const PortakalPressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scale = 0.94,
    this.duration = const Duration(milliseconds: 100),
    this.dismissCount,
    this.cooldown = const Duration(seconds: 1),
  });

  @override
  State<PortakalPressable> createState() => _PortakalPressableState();
}

class _PortakalPressableState extends State<PortakalPressable> {
  late final PManager<double> _scaleManager;

  bool _longPressTriggered = false;
  int _tapCounter = 0;
  Timer? _resetTimer;

  @override
  void initState() {
    super.initState();
    _scaleManager = PManager<double>(1.0);
  }

  void _animate(bool down) {
    _scaleManager.set(down ? widget.scale : 1.0);
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _animate(true),
      onTapUp: (_) {
        if (_longPressTriggered) {
          _animate(false);
          _longPressTriggered = false;
          return;
        }

        if (widget.dismissCount != null) {
          _resetTimer?.cancel();

          if (_tapCounter >= widget.dismissCount!) {
            _resetTimer = Timer(widget.cooldown, () {
              _tapCounter = 0;
            });
            return;
          }

          _tapCounter++;
          _resetTimer = Timer(widget.cooldown, () {
            _tapCounter = 0;
          });
        }

        Future.delayed(widget.duration, () {
          if (mounted) {
            _animate(false);
            if (widget.onTap != null) widget.onTap!();
          }
        });
      },
      onTapCancel: () {
        _animate(false);
        _longPressTriggered = false;
      },
      onLongPress: widget.onLongPress == null
          ? null
          : () {
              _longPressTriggered = true;
              if (widget.onLongPress == null) return;
              widget.onLongPress!();
            },
      child: PManagerListenerSingle(
        listenable: _scaleManager,
        childBuilder: () {
          return AnimatedScale(
            scale: _scaleManager(),
            duration: widget.duration,
            curve: Curves.easeInOut,
            child: widget.child,
          );
        },
      ),
    );
  }
}
