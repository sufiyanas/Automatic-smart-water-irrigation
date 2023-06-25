import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(" WATER IRRIGATION"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Customtile(leadingText: "Moisture :", trailingtext: "20"),
          const Customtile(leadingText: "Temperature :", trailingtext: "30"),
          const Customtile(leadingText: "Humidity :", trailingtext: "40"),
          //  const Spacer(),
          const SizedBox(
            height: 40,
          ),
          MaterialButton(
            color: Colors.white,
            onPressed: () {},
            child: const Text("History", style: const TextStyle(fontSize: 19)),
          )
        ],
      ),
    );
  }
}

class Customtile extends StatelessWidget {
  const Customtile({
    super.key,
    required this.leadingText,
    required this.trailingtext,
  });
  final leadingText;
  final trailingtext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListTile(
        leading: Text(
          leadingText,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        trailing: Text(
          trailingtext,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
