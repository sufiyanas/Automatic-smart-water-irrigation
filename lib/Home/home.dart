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
  bool isLoading = false;
  String moisture = "0";
  String temperature = "0";
  String humidity = "0";
  String entryID = "0";
  bool isHttpRequest = false;

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   makeHttpRequest(context);
  // }

  void makeHttpRequest(BuildContext context) async {
    log("called");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fetching Data'),
          content: const Text('Please wait...'),
        );
      },
    );

    var url = Uri.parse(
        'https://api.thingspeak.com/channels/2215399/feeds.json?api_key=LS8VC0KIFFQ1UNCF&results=2');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        log(200.toString());
        var responseData = jsonDecode(response.body);
        var feeds = responseData['feeds'];

        if (feeds != null && feeds.isNotEmpty) {
          var latestFeed = feeds.last;
          log(latestFeed.toString());
          setState(() {
            entryID = latestFeed['entry_id'] != null
                ? latestFeed['entry_id'].toString()
                : "0";
            moisture = latestFeed['field1'] != null
                ? latestFeed['field1'].toString()
                : "0";
            temperature = latestFeed['field2'] != null
                ? latestFeed['field2'].toString()
                : "0";
            humidity = latestFeed['field3'] != null
                ? latestFeed['field3'].toString()
                : "0";
          });
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      Navigator.of(context).pop(); // Close the alert dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      if (!isHttpRequest) {
        isHttpRequest = true;
        makeHttpRequest(context);
      }
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(" WATER IRRIGATION"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundImage.jpg"),
                fit: BoxFit.cover)),
        child: Column(
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
                makeHttpRequest(context);

                // buttonclick(context);
              },
              child:
                  const Text("Refresh", style: const TextStyle(fontSize: 19)),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Entryid = $entryID",
                style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
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
