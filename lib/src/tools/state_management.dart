import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// PManager is a custom ChangeNotifier wrapper that allows
/// getting, setting, and manually notifying listeners of a value.
class PManager<T> extends ChangeNotifier {
  /// Creates a PManager instance with an initial value.
  PManager(this._value);

  T _value;

  /// Returns the current value.
  T call() => _value;

  /// Sets a new value without notifying listeners.
  void callSet(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
  }

  /// Sets a new value and notifies all listeners.
  void set(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  /// Manually notifies listeners without changing the value.
  void up() {
    notifyListeners();
  }

  /// Notifies listeners for multiple PManager instances at once.
  static void multiUp(List<PManager> list) {
    for (var pm in list) {
      pm.notifyListeners();
    }
  }

  /// Returns a string representation of the object for debugging.
  @override
  String toString() => '${describeIdentity(this)}($_value)';
}

/// A widget that listens to multiple PManager instances and rebuilds
/// its child when any of them changes.
class PManagerListener extends StatelessWidget {
  /// The list of PManager objects to listen to.
  final List<PManager> listenables;

  /// Builder function that returns the child widget.
  final Widget Function() childBuilder;

  const PManagerListener({
    super.key,
    required this.listenables,
    required this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      /// Merges multiple listenables into a single animation.
      animation: Listenable.merge(listenables),
      builder: (context, _) => childBuilder(),
    );
  }
}

/// A widget that listens to a single PManager instance and rebuilds
/// its child when the PManager changes.
class PManagerListenerSingle extends StatelessWidget {
  /// The PManager object to listen to.
  final PManager listenable;

  /// Builder function that returns the child widget.
  final Widget Function() childBuilder;

  const PManagerListenerSingle({
    super.key,
    required this.listenable,
    required this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      /// Directly listen to a single PManager without merge overhead
      animation: listenable,
      builder: (context, _) => childBuilder(),
    );
  }
}

/// A custom Scaffold that rebuilds its body whenever
/// the specified PManager listenables change.
class PManagerScaffold extends StatefulWidget {
  const PManagerScaffold({
    super.key,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    required this.listenables,
    required this.body,
  });

  final PreferredSizeWidget? appBar;
  final List<PManager<dynamic>> listenables;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  /// Builder function that returns the body widget.
  final Widget Function() body;

  @override
  State<PManagerScaffold> createState() => _PManagerScaffoldState();
}

class _PManagerScaffoldState extends State<PManagerScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: widget.appBar,

      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      persistentFooterAlignment: widget.persistentFooterAlignment,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      restorationId: widget.restorationId,

      /// Body wrapped in a PManagerListener to rebuild on PManager changes.
      body: PManagerListener(
        listenables: widget.listenables,
        childBuilder: widget.body,
      ),
    );
  }
}
