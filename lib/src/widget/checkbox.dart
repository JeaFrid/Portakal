import 'package:flutter/material.dart';

class PortakalCheckBox extends StatefulWidget {
  final void Function(bool) onTap;
  final void Function(bool)? onLongPress;
  final double size;
  final Color? color;
  final bool? initStatus;

  const PortakalCheckBox({
    super.key,
    required this.onTap,
    required this.size,
    this.initStatus,
    this.onLongPress,
    this.color,
  });

  @override
  State<PortakalCheckBox> createState() => _PortakalCheckBoxState();
}

class _PortakalCheckBoxState extends State<PortakalCheckBox> {
  late final ValueNotifier<bool> _isCheckedNotifier;

  @override
  void initState() {
    super.initState();
    _isCheckedNotifier = ValueNotifier(widget.initStatus ?? false);
  }

  @override
  void dispose() {
    _isCheckedNotifier.dispose();
    super.dispose();
  }

  void _handleTap() {
    _isCheckedNotifier.value = !_isCheckedNotifier.value;
    widget.onTap(_isCheckedNotifier.value);
  }

  void _handleLongPress() {
    _isCheckedNotifier.value = !_isCheckedNotifier.value;
    if (widget.onLongPress != null) {
      widget.onLongPress!(_isCheckedNotifier.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isCheckedNotifier,
      builder: (context, isChecked, child) {
        return InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: _handleTap,
          onLongPress: _handleLongPress,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.color ?? Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(2),
            child: AnimatedOpacity(
              opacity: isChecked ? 1 : 0,
              duration: Durations.short1,
              child: Icon(
                Icons.check,
                color: widget.color ?? Colors.white,
                size: widget.size,
              ),
            ),
          ),
        );
      },
    );
  }
}