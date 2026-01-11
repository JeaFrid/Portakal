import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum PortakalDeviceType {
  isDesktop("desktop"),
  isTablet("tablet"),
  isMobile("mobile");

  final String type;
  const PortakalDeviceType(this.type);
}

class PortakalResponsive extends StatelessWidget {
  final Widget Function(BuildContext context, PortakalDeviceType type) builder;

  const PortakalResponsive({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        PortakalDeviceType type;

        if (constraints.maxWidth < 600) {
          type = PortakalDeviceType.isMobile;
        } else if (constraints.maxWidth < 900) {
          type = PortakalDeviceType.isTablet;
        } else {
          type = PortakalDeviceType.isDesktop;
        }

        return builder(context, type);
      },
    );
  }
}

class PortakalWindow {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static void platformFunction({
    Function()? isWindows,
    Function()? isMacOS,
    Function()? isLinux,
    Function()? isWeb,
    Function()? isAndroid,
    Function()? isIOS,
  }) {
    if (kIsWeb) {
      if (isWeb != null) {
        isWeb();
      }
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      if (isWindows != null) {
        isWindows();
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      if (isAndroid != null) {
        isAndroid();
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      if (isIOS != null) {
        isIOS();
      }
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      if (isLinux != null) {
        isLinux();
      }
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      if (isMacOS != null) {
        isMacOS();
      }
    }
  }

  static void platformFunctionWithBoolean(
    Function() func, {
    bool? isWindows,
    bool? isMacOS,
    bool? isLinux,
    bool? isWeb,
    bool? isAndroid,
    bool? isIOS,
  }) {
    if (isWeb == true) {
      func();
    } else if (isWindows == true) {
      func();
    } else if (isAndroid == true) {
      func();
    } else if (isIOS == true) {
      func();
    } else if (isLinux == true) {
      func();
    } else if (isMacOS == true) {
      func();
    }
  }

  static Future<T?> pushFromRightToLeft<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushFromLeftToRight<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushDownFromTop<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushTopFromDown<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushNonAnimated<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 0),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  static Future<T?> pushFromRightToLeftReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushFromLeftToRightReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushDownFromTopReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushTopFromDownReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return route;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushNonAnimatedReplacement<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 0),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
