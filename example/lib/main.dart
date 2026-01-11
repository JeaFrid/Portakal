// To take advantage of the features of the Material Package
import 'package:flutter/material.dart';
// Here's Portakal🧡
import 'package:portakal/portakal.dart';
/*
We are manipulating the window in Windows applications.
If you are not coding a Windows application, delete this line and remove it from dependencies.
*/
import 'package:bitsdojo_window/bitsdojo_window.dart';
// We've added a small env file for you.
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*Hello Portakal Developer! 🍊 It's excellent that you chose to use Portakal!
You are inside a project manipulated with Portakal Manipulation.
This project provides you with many customized settings.

Visit Github for all the information!

We wrote a mini app for you to enjoy.
You can customize it or start over by deleting it!
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We are adding the .env file to the project.
  await dotenv.load(fileName: ".env");
  // To ensure smooth Portakal coding, Portakal must be started.
  await Portakal.init();
  runApp(const PortakalApp());

  // Window settings
  doWhenWindowReady(() {
    const initialSize = Size(800, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class PortakalApp extends StatelessWidget {
  const PortakalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PortakalMaterialApp(
      title: 'Portakal App🍊',
      developerTools: true,
      home: const PortakalBMI(),
    );
  }
}

class PortakalBMI extends StatefulWidget {
  const PortakalBMI({super.key});

  @override
  State<PortakalBMI> createState() => _PortakalBMIState();
}

class _PortakalBMIState extends State<PortakalBMI> {
  // We use Portakal's PManager for a simplified State Manager.
  PManager<String> buttonData = PManager<String>("Calculate");
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PManagerScaffold(
      listenables: [buttonData],
      body: () {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              h1(context, "🍊Welcome Portakal BMI!🧡"),
              SizedBox(
                width: PortakalWindow.width(context) * 0.3,
                child: Divider(
                  color: PortakalTheme.defaultColor(),
                  thickness: 1,
                ),
              ),
              SizedBox(
                width: PortakalWindow.width(context) * 0.5,
                child: PortakalTextField(
                  textController: heightController,
                  text: "Centimeters",
                  bgColor: PortakalTheme.cardColor(),
                  icon: Icons.accessibility_outlined,
                ),
              ),
              SizedBox(
                width: PortakalWindow.width(context) * 0.5,
                child: PortakalTextField(
                  textController: weightController,
                  text: "Kilograms",
                  bgColor: PortakalTheme.cardColor(),
                  icon: Icons.balance_outlined,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: PortakalWindow.width(context) * 0.5 - 20,
                child: PortakalButton(
                  type: PortakalButtonType.duotone,
                  text: "🧮 ${buttonData()} 🧮",
                  onTap: () async {
                    double height = double.parse(heightController.text) / 100;
                    double weight = double.parse(weightController.text);
                    double bmi = weight / (height * height);
                    buttonData.set(bmi.toStringAsFixed(2));
                    await Future.delayed(Duration(seconds: 5));
                    buttonData.set("Calculate");
                    heightController.clear();
                    weightController.clear();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
