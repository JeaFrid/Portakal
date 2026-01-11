# Portakal 🍊

**Portakal**, developed by **JeaFriday**.

Portakal is a comprehensive Flutter toolkit designed to accelerate development. It provides a robust lightweight state management system (`PManager`), a dynamic theming engine, pre-styled UI components, responsive layout builders, and essential utility tools—all in one package.

## 🚀 Features

-   **State Management:** Ultra-lightweight `PManager` system for reactive UI updates without boilerplate.
-   **Dynamic Theming:** Built-in Dark/Light mode switching with persistent state and custom color palettes.
-   **Smart UI Components:**
    -   `PortakalButton`: Various styles (Ghost, Duotone, Raindrop, Border, etc.) with cooldowns.
    -   `PortakalPressable`: Tactile feedback (scaling animation) for any widget.
    -   `PortakalTextField`: Pre-styled inputs with icons and success states.
    -   `PortakalCheckBox`: Custom animated checkboxes.
-   **Persistent Image Caching:** `PortakalImage` handles network caching via Hive automatically.
-   **Dev Tools Overlay:** A draggable, floating overlay in debug mode to inspect device info and theme states.
-   **Navigation & Window:** Custom slide transitions (Left, Right, Top, Bottom) and platform detection.
-   **Utilities:** Validators, Random Generators, Extensions, and Clipboard tools.

---

## Portakal CLI 🍊

Portakal is a powerful CLI (Command Line Interface) automation tool that allows you to start your Flutter projects beyond standard defaults, with a "freshly squeezed" and ready-to-use structure.

Leave the tedious tasks to Portakal and enjoy coding! 🧡

https://github.com/JeaFrid/Portakal-Manipulation

---

## 📦 Installation

Add `portakal` to your `pubspec.yaml`:

```yaml
dependencies:
  portakal: ^0.0.1
```

## ⚙️ Initialization

Initialize `Portakal` in your `main.dart` before running the app. This sets up Hive for caching and database management.

```dart
import 'package:flutter/material.dart';
import 'package:portakal/portakal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Portakal (Database & Image Cache)
  await Portakal.init(
    setFontBuilder: (style) {
      // Optional: Global font configuration
      return style.copyWith(fontFamily: 'Roboto');
    },
  );

  runApp(const MyApp());
}
```

## 🛠 Usage

### 1. App Wrapper (`PortakalMaterialApp`)

Use `PortakalMaterialApp` instead of the standard `MaterialApp`. This handles the global theme listening and injects the Dev Overlay.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PortakalMaterialApp(
      title: 'My Portakal App',
      home: HomePage(),
      // Theming is handled automatically, but you can override:
      // themeMode: ThemeMode.system, 
    );
  }
}
```

### 2. State Management (`PManager`)

`PManager` is a simple wrapper around `ChangeNotifier`.

**Defining State:**
```dart
// Define a global or local manager
final PManager<int> counter = PManager(0);
```

**Listening to Changes:**
```dart
PManagerListenerSingle(
  listenable: counter,
  childBuilder: () {
    return Text("Count: ${counter()}"); // Access value using .call() or ()
  },
)
```

**Updating State:**
```dart
// Update and notify listeners
counter.set(counter() + 1);

// Update WITHOUT notifying (if needed)
counter.callSet(5); 
```

### 3. Theming & Colors

Portakal has a centralized theme controller.

**Accessing Colors:**
```dart
Container(
  color: PortakalTheme.cardColor(),
  child: Text("Hello", style: TextStyle(color: PortakalTheme.textColor())),
)
```

**Switching Theme:**
```dart
PortakalButton(
  type: PortakalButtonType.normal,
  text: "Toggle Theme",
  onTap: () {
    if (PortakalTheme.isDarkMode()) {
      PortakalTheme.setLightThemeData();
    } else {
      PortakalTheme.setDarkThemeData();
    }
  },
)
```

### 4. UI Components

#### Buttons
Buttons come with built-in cooldowns to prevent spam clicking.

```dart
PortakalButton(
  type: PortakalButtonType.duotone, // normal, border, ghost, raindrop, etc.
  text: "Click Me",
  onTap: () => print("Clicked"),
  backgroundColor: Colors.blue, 
)
```

#### Images
Display images from Network, File, Asset, or Memory with automatic caching and error handling.

```dart
PortakalImage(
  path: "[https://example.com/image.png](https://example.com/image.png)",
  width: 100,
  height: 100,
  borderRadius: BorderRadius.circular(12),
  fit: BoxFit.cover,
)
```

#### Text Shorthands
Quickly access theme-styled text widgets.

```dart
Column(
  children: [
    h1(context, "Headline 1"),
    h3(context, "Subtitle"),
    p(context, "Regular paragraph text..."),
    bold(context, "Bold Text"),
  ],
)
```

### 5. Navigation & Responsiveness

**Custom Transitions:**
```dart
// Slide page from Right to Left
PortakalWindow.pushFromRightToLeft(context, SecondPage());

// Slide page from Bottom to Top
PortakalWindow.pushTopFromDown(context, ModalPage());
```

**Responsive Layout:**
```dart
PortakalResponsive(
  builder: (context, deviceType) {
    if (deviceType == PortakalDeviceType.isMobile) {
      return MobileView();
    } else if (deviceType == PortakalDeviceType.isTablet) {
      return TabletView();
    }
    return DesktopView();
  },
)
```

### 6. Tools & Extensions

**Extensions:**
```dart
context.width;      // MediaQuery width
context.height;     // MediaQuery height
context.hideKeyboard(); 

20.h; // SizedBox(height: 20)
10.w; // SizedBox(width: 10)

"hello world".capitalize(); // "Hello world"
```

**Validators:**
```dart
PortakalValidator.email("test@test.com"); // Returns null if valid, error string if not
PortakalValidator.password("123", minLength: 6);
```

**Random Generator:**
```dart
String id = PortakalRandom.randomWithTime();
String password = PortakalRandom.password();
```

---

## 🐛 Dev Overlay

When in `Debug Mode`, a floating **🍊** icon appears. Tapping it expands a panel showing:
-   Screen Resolution & Pixel Ratio.
-   Device Orientation.
-   Platform (Android/iOS/Web).
-   Safe Area padding.
-   Current Theme Brightness.

This overlay is draggable and saves its position/state using `PortakalDB`.

---

## 📄 License

Developed by **JeaFriday**.