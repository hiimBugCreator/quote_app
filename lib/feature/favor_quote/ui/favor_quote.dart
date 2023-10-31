import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/resources/routes_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.beamToNamed(quoteRoute);
          },
          child: const Text("Back"),
        ),
      ),
    );
  }
}