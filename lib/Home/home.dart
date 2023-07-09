import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    makeHttpRequest(context);
  }

  String moisture = "0";
  String temperature = "0";
  String humidity = "0";

  void makeHttpRequest(BuildContext context) async {
    log("clicked");

    var url = Uri.parse(
        'https://api.thingspeak.com/channels/2215399/fields/1.json?api_key=LS8VC0KIFFQ1UNCF&results=2');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request successful, parse response
      var responseData = jsonDecode(response.body);
      var channel = responseData['channel'];
      setState(() {
        moisture = channel['field1'];
        temperature = channel['field2'];
        humidity = channel['field3'];
      });

      // Process responseData as needed
      // print(responseData);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Something went wrong .....:('),
      //   ),
      // );
      // Request failed, print error me
      // ssage
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void buttonclick(BuildContext context) async {
    log("clicked");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('fetching......:)'),
      ),
    );
    var url = Uri.parse(
        'https://api.thingspeak.com/channels/2215399/fields/1.json?api_key=LS8VC0KIFFQ1UNCF&results=2');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request successful, parse response
      var responseData = jsonDecode(response.body);
      var channel = responseData['channel'];
      setState(() {
        moisture = channel['field1'];
        temperature = channel['field2'];
        humidity = channel['field3'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Updated with new value......:)'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something wend Wrong......:('),
        ),
      );
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
          Customtile(leadingText: "Moisture :", trailingtext: moisture),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.white70,
            ),
          ),
          Customtile(leadingText: "Temperature :", trailingtext: temperature),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              thickness: 0.5,
              color: Colors.white70,
            ),
          ),
          Customtile(leadingText: "Humidity :", trailingtext: humidity),
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
            onPressed: () async {
              buttonclick(context);
            },
            child: const Text("Refresh", style: const TextStyle(fontSize: 19)),
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
