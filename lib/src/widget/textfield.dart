import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portakal/src/theme/icon.dart';
import 'package:portakal/src/theme/icons.dart';
import 'package:portakal/src/theme/theme.dart';
import 'package:portakal/src/widget/pressable.dart';

class PortakalTextField extends StatelessWidget {
  final String? text;
  final TextEditingController? textController;
  final bool? obscureText;
  final String? imageIcon;
  final IconData? icon;
  final IconData? onSucccessIcon;
  final Function()? onSucccess;
  final Function()? onTap;
  final bool? readOnly;
  final FontWeight? fontWeight;
  final double? size;
  final BoxConstraints? constraints;
  final bool? nonMargin;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final Color? bgColor;
  final bool? nonLabel;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const PortakalTextField({
    super.key,
    this.text,
    this.textController,
    this.obscureText,
    this.imageIcon,
    this.icon,
    this.onSucccessIcon,
    this.onSucccess,
    this.onTap,
    this.readOnly,
    this.fontWeight,
    this.size,
    this.constraints,
    this.nonMargin,
    this.boxShadow,
    this.color,
    this.bgColor,
    this.nonLabel,
    this.inputFormatters,
    this.onEditingComplete,
    this.onChanged,
    this.maxLines = 1,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    TextField textFields = TextField(
      readOnly: readOnly ?? false,
      controller: textController,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      cursorColor: PortakalTheme.defaultColor(),
      style: TextStyle(
        color: color ?? PortakalTheme.textColor(),
        fontSize: size,
        fontWeight: fontWeight,
      ),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: nonLabel != true ? text : null,
        labelStyle: nonLabel != true
            ? TextStyle(
                color: (color ?? PortakalTheme.textColor()).withOpacity(0.5),
              )
            : null,
        hintText: nonLabel == true ? text : null,
        hintStyle: nonLabel == true
            ? TextStyle(
                color: (color ?? PortakalTheme.textColor()).withOpacity(0.5),
                fontSize: size,
                fontWeight: fontWeight,
              )
            : null,
        isDense: true,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(8),
      constraints: constraints,
      margin: nonMargin == true
          ? null
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(5),
        color: bgColor ?? Colors.transparent,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Visibility(
                visible: imageIcon != null,
                child: Row(
                  children: [
                    Image.asset(
                      imageIcon ?? "",
                      color: PortakalTheme.defaultColor(),
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              Visibility(
                visible: icon != null,
                child: Row(
                  children: [
                    Icon(
                      icon ?? Icons.search,
                      color: PortakalTheme.defaultColor(),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              Expanded(
                child: onTap != null
                    ? PortakalPressable(
                        onTap: onTap,
                        child: AbsorbPointer(child: textFields),
                      )
                    : textFields,
              ),
              if (suffix != null) ...[const SizedBox(width: 8), suffix!],
              Visibility(
                visible: onSucccess != null,
                child: Row(
                  children: const [
                    SizedBox(width: 12),
                    SizedBox(width: 20, height: 20),
                    SizedBox(width: 6),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 6,
            top: 14,
            child: Visibility(
              visible: onSucccess != null,
              child: PortakalPressable(
                onTap: () {
                  if (onSucccess != null) {
                    onSucccess!();
                  }
                },
                child: onSucccessIcon != null
                    ? Icon(
                        onSucccessIcon,
                        size: 22,
                        color: PortakalTheme.textColor(),
                      )
                    : PortakalIcon(
                        PortakalIcons.boldPaperPlaneRightBold,
                        size: 22,
                        color: PortakalTheme.defaultColor(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
