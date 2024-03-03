import 'package:calendar_app/screens/big_calendar_screen.dart';
import 'package:calendar_app/screens/calendar_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return const Scaffold(
                backgroundColor: Colors.grey, body: BigCalendarScreen());
          } else {
            return const CalendarScreen();
          }
        },
      ),
    );
  }
}

class BasePage extends StatelessWidget {
  final Widget child;
  const BasePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Center(
            child: SizedBox(
                width: mWidth > 600 ? screenSize.width * 0.5 : screenSize.width,
                height: screenSize.height,
                child: child),
          ),
        ),
      ),
    );
  }
}
