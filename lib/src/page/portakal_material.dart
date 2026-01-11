import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portakal/portakal.dart';

class PortakalMaterialApp extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, Widget Function(BuildContext)> routes;
  final String? initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Route<dynamic>? Function(RouteSettings)? onUnknownRoute;
  final bool Function(NavigationNotification)? onNavigationNotification;
  final List<NavigatorObserver> navigatorObservers;
  final Widget Function(BuildContext, Widget?)? builder;
  final String title;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
  localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool developerTools;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool useInheritedMediaQuery;
  final AnimationStyle? themeAnimationStyle;

  const PortakalMaterialApp({
    super.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = 'Portakal App',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.developerTools = true,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
    this.themeAnimationStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PManagerListener(
      listenables: [
        PortakalTheme.theme,
        PortakalTheme.defaultColor,
        PortakalTheme.textColor,
        PortakalTheme.cardColor,
        PortakalTheme.secondCardColor,
        PortakalTheme.background,
      ],
      childBuilder: () {
        return MaterialApp(
          theme: PortakalTheme.getThemeData(),
          darkTheme: darkTheme,
          highContrastTheme: highContrastTheme,
          highContrastDarkTheme: highContrastDarkTheme,
          themeMode: themeMode,
          themeAnimationDuration: themeAnimationDuration,
          themeAnimationCurve: themeAnimationCurve,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: Stack(
            children: [
              home == null
                  ? Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            h1(context, "🧡"),
                            SizedBox(height: 10),
                            h3(
                              context,
                              "Hi Developer! You're using the Portakal vehicle. Thanks 🧡🍊",
                            ),
                            p(
                              context,
                              "Use the 'home:' attribute to begin coding.",
                            ),
                            SizedBox(height: 28),
                            IntrinsicWidth(
                              child: PortakalButton(
                                type: PortakalButtonType.duotone,
                                text: "Go pub.dev🍊",
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : home ?? Container(),
              if (kDebugMode && developerTools) const _PortakalDevOverlay(),
            ],
          ),
          routes: routes,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onGenerateInitialRoutes: onGenerateInitialRoutes,
          onUnknownRoute: onUnknownRoute,
          onNavigationNotification: onNavigationNotification,
          navigatorObservers: navigatorObservers,
          builder: builder,
          title: title,
          onGenerateTitle: onGenerateTitle,
          color: color,
          locale: locale,
          localizationsDelegates: localizationsDelegates,
          localeListResolutionCallback: localeListResolutionCallback,
          localeResolutionCallback: localeResolutionCallback,
          supportedLocales: supportedLocales,
          debugShowMaterialGrid: debugShowMaterialGrid,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowCheckedModeBanner: false,
          shortcuts: shortcuts,
          actions: actions,
          restorationScopeId: restorationScopeId,
          scrollBehavior: scrollBehavior,
          useInheritedMediaQuery: useInheritedMediaQuery,
          themeAnimationStyle: themeAnimationStyle,
        );
      },
    );
  }
}

class _PortakalDevOverlay extends StatefulWidget {
  const _PortakalDevOverlay();

  @override
  State<_PortakalDevOverlay> createState() => _PortakalDevOverlayState();
}

class _PortakalDevOverlayState extends State<_PortakalDevOverlay> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier(true);
  final ValueNotifier<Offset> _position = ValueNotifier(const Offset(20, 50));

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    _position.dispose();
    super.dispose();
  }

  Future<void> _loadState() async {
    final double? x = await PortakalDB.get('portakal_dev_x');
    final double? y = await PortakalDB.get('portakal_dev_y');
    final bool? expanded = await PortakalDB.get('portakal_dev_expanded');

    if (x != null && y != null) {
      _position.value = Offset(x, y);
    }
    if (expanded != null) {
      _isExpanded.value = expanded;
    }
  }

  Future<void> _saveState() async {
    await PortakalDB.save('portakal_dev_x', _position.value.dx);
    await PortakalDB.save('portakal_dev_y', _position.value.dy);
    await PortakalDB.save('portakal_dev_expanded', _isExpanded.value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return ValueListenableBuilder<Offset>(
      valueListenable: _position,
      builder: (context, currentPosition, _) {
        return Positioned(
          left: currentPosition.dx,
          top: currentPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              _position.value += details.delta;
            },
            onPanEnd: (details) {
              _saveState();
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: _isExpanded,
              builder: (context, isExpanded, _) {
                return Material(
                  type: MaterialType.transparency,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutBack,
                    width: isExpanded ? 240 : 50,
                    height: isExpanded ? 340 : 50,
                    decoration: BoxDecoration(
                      color: PortakalTheme.cardColor().withOpacity(0.95),
                      borderRadius: BorderRadius.circular(isExpanded ? 20 : 25),
                      border: Border.all(
                        color: PortakalTheme.defaultColor(),
                        width: 1.6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isExpanded ? 18 : 23),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        child: isExpanded
                            ? OverflowBox(
                                key: ValueKey("expanded"),
                                minWidth: 240,
                                maxWidth: 240,
                                minHeight: 340,
                                maxHeight: 340,
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  height: 340,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            h5(context, "Portakal Dev 🧡"),
                                            InkWell(
                                              onTap: () {
                                                _isExpanded.value = false;
                                                _saveState();
                                              },
                                              child: Icon(
                                                Icons.close_fullscreen_rounded,
                                                size: 18,
                                                color:
                                                    PortakalTheme.textColor(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: PortakalTheme.defaultColor(),
                                        height: 1,
                                        thickness: 1,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildInfoRow(
                                                "Size",
                                                "${mediaQuery.size.width.toInt()} x ${mediaQuery.size.height.toInt()}",
                                              ),
                                              _buildInfoRow(
                                                "PixelRatio",
                                                mediaQuery.devicePixelRatio
                                                    .toStringAsFixed(2),
                                              ),
                                              _buildInfoRow(
                                                "Orientation",
                                                mediaQuery.orientation.name,
                                              ),
                                              _buildInfoRow(
                                                "Platform",
                                                defaultTargetPlatform.name,
                                              ),
                                              Divider(
                                                color: PortakalTheme.textColor()
                                                    .withOpacity(0.2),
                                              ),
                                              bold(context, "Safe Area:"),
                                              _buildInfoRow(
                                                "Top / Bottom",
                                                "${mediaQuery.padding.top.toInt()} / ${mediaQuery.padding.bottom.toInt()}",
                                              ),
                                              Divider(
                                                color: PortakalTheme.textColor()
                                                    .withOpacity(0.2),
                                              ),
                                              bold(context, "Theme:"),
                                              _buildInfoRow(
                                                "Brightness",
                                                theme.brightness.name,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                key: ValueKey("collapsed"),
                                width: 50,
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    _isExpanded.value = true;
                                    _saveState();
                                  },
                                  borderRadius: BorderRadius.circular(25),
                                  child: Center(
                                    child: Text(
                                      "🍊",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: PortakalTheme.textColor(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: PortakalTheme.textColor().withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
