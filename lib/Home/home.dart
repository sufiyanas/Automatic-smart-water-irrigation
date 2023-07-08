import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void makeHttpRequest() async {
    var url = Uri.parse(
        'https://api.thingspeak.com/channels/2215399/fields/1.json?api_key=LS8VC0KIFFQ1UNCF&results=2');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request successful, parse response
      var responseData = response.body;
      // Process responseData as needed
      print(responseData);
    } else {
      // Request failed, print error message
      print('Request failed with status: ${response.statusCode}');
    }
  }

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.white70,
            ),
          ),
          const Customtile(leadingText: "Temperature :", trailingtext: "30"),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.white70,
            ),
          ),
          const Customtile(leadingText: "Humidity :", trailingtext: "40"),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.white70,
            ),
          ),
          //  const Spacer(),
          const SizedBox(
            height: 40,
          ),
          MaterialButton(
            color: Colors.white,
            onPressed: () {
              makeHttpRequest();
            },
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
