import 'package:flutter/material.dart';
import 'package:portakal/src/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                if (PortakalTheme.isDarkMode()) {
                  PortakalTheme.setLightThemeData();
                } else {
                  PortakalTheme.setDarkThemeData();
                }
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: PortakalTheme.defaultColor()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
