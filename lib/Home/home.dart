import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Automatic water Irrigation"),
        backgroundColor: Colors.transparent,
      ),
      body: const Column(
        children: [
          Text(
            "Bla bla",
          ),
          Text(
            "Bla bla",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Bla bla",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Bla bla",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Bla bla",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
