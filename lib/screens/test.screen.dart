import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestNavBar extends StatefulWidget {
  const TestNavBar({super.key});

  @override
  State<TestNavBar> createState() => _TestNavBarState();
}

class _TestNavBarState extends State<TestNavBar> {
  double horizantalPadding = 50.0;
  double horizantalMargin = 20.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          color: Colors.amber,
        ),
      ),
    );
  }
}
