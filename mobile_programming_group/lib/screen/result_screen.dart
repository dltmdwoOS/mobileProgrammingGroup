import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../service/file_service.dart';

class TextProcessingApp extends StatefulWidget {
  final String country;
  final String state;
  final String currency;
  final String budget;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String companion;
  final String style;

  TextProcessingApp({
    required this.country,
    required this.state,
    required this.currency,
    required this.budget,
    required this.departureDate,
    required this.arrivalDate,
    required this.companion,
    required this.style,
  });

  @override
  _TextProcessingAppState createState() => _TextProcessingAppState();
}

class _TextProcessingAppState extends State<TextProcessingApp> {
  final TextEditingController _controller = TextEditingController();
  String _response = "";
  bool _isLoading = false;

  Future<void> processText() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse("http://34.64.251.203:8080/process_text");
      List<Map<String, String>> conversation = [
        {
          "role": "system",
          "content": "You are a travel consultant who creates a travel itinerary for users by inputting their destination, period, and budget. You should respond similarly to the example format below. The recommended plan should be compact, yet full of information and should be as detailed as possible. It should be written in Python dictionary(Map format) form as follows",
        },
        {
          "role": "system",
          "content": "When user said 'I'll go Osaka, Japan, for 1 / 5 ~ 1 / 7, and my budget is 2000 USD with four people(family)', and then you should respond like: \nTravel destination : Osaka, Japan\nPeriod : 1/5 ~ 1/7\nBudget : 2000 USD\nPeople : 4\nRecommended plan : \n{\"1/5\":\n\"Morning: Morning plan for 1/5, \nAfternoon: Afternoon plan for 1/5, \nNight: Night plan for 1/5\", \n\"1/6\":\n\"Morning: Morning plan for 1/6, \nAfternoon: Afternoon plan for 1/6, \nNight: Night plan for 1/6\", \n\"1/7\":\n\"Morning: Morning plan for 1/7, \nAfternoon: Afternoon plan for 1/7, \nNight: Night plan for 1/7\"}",
        },
        {
          "role": "system",
          "content": "You don't have to comment about total cost, total budget, ... etc. Answer correctly only in the above format.",
        },
        {
          "role": "user",
          "content": "I'll go ${widget.country}, ${widget.state}, for ${widget.departureDate.toLocal().month} / ${widget.departureDate.toLocal().day} ~ ${widget.arrivalDate.toLocal().month} / ${widget.arrivalDate.toLocal().day}, and my budget is ${widget.budget} ${widget.currency} with ${widget.companion}."
        }
      ];
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(conversation),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String path = "outputs";
        int fileCount = await countFiles(path);
        await saveJsonToFile(responseData, "$path/plan_${fileCount+1}");
        setState(() {
          _response = "Data saved successfully!";
        });
      } else {
        setState(() {
          _response = "Error: ${response.statusCode}, ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "Failed to process text: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Processing App")),
      body: _isLoading
          ? Center(
        child: Container(
          color: Colors.black54,
          child: CircularProgressIndicator(),
        ),
      )
          : Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter text"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                processText();
              },
              child: Text("Process Text"),
            ),
            SizedBox(height: 20),
            Text("Response: $_response"),
          ],
        ),
      )
      /*
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Enter text"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    processText();
                  },
                  child: Text("Process Text"),
                ),
                SizedBox(height: 20),
                Text("Response: $_response"),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: Container(
                color: Colors.black54,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),*/
    );
  }
}