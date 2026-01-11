import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:portakal/src/theme/theme.dart';

enum PortakalStateStatus { loading, success, error, empty }

class PortakalStateWrapper extends StatelessWidget {
  final PortakalStateStatus status;
  final Widget successWidget;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final VoidCallback? onRetry;
  final String? errorMessage;

  const PortakalStateWrapper({
    super.key,
    required this.status,
    required this.successWidget,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.onRetry,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case PortakalStateStatus.loading:
        return Center(
          child:
              loadingWidget ??
              CupertinoActivityIndicator(color: PortakalTheme.defaultColor()),
        );
      case PortakalStateStatus.error:
        return Center(
          child:
              errorWidget ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage ?? "Bir hata oluştu",
                    style: TextStyle(color: PortakalTheme.textColor()),
                  ),
                  if (onRetry != null) ...[
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: onRetry,
                      child: Text(
                        "Tekrar Dene",
                        style: TextStyle(color: PortakalTheme.defaultColor()),
                      ),
                    ),
                  ],
                ],
              ),
        );
      case PortakalStateStatus.empty:
        return Center(
          child:
              emptyWidget ??
              Text(
                "Veri bulunamadı",
                style: TextStyle(color: PortakalTheme.textColor()),
              ),
        );
      case PortakalStateStatus.success:
        return successWidget;
    }
  }
}
