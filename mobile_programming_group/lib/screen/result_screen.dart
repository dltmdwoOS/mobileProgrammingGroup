import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../service/file_service.dart';

class ResultScreen extends StatefulWidget {
  final String planName;
  ResultScreen({required this.planName});
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, Map<String, dynamic>>? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final path = "outputs/${widget.planName}.txt";
      Map<String, Map<String, dynamic>>? result = await readJsonFromFile(path);

      if (result == null) {
        throw Exception("Data is null. Check file content or path.");
      }

      setState(() {
        data = result;
      });
    } catch (e) {
      print("Error loading data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedKeys = data!.keys.toList()
      ..sort((a, b) {
        DateTime dateA = DateTime.parse('2024-${a.split('/')[0].padLeft(2, '0')}-${a.split('/')[1].padLeft(2, '0')}');
        DateTime dateB = DateTime.parse('2024-${b.split('/')[0].padLeft(2, '0')}-${b.split('/')[1].padLeft(2, '0')}');
        return dateA.compareTo(dateB);
      });
    return Scaffold(
      appBar: AppBar(title: Text('Travel Summary')),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: sortedKeys.length,
        itemBuilder: (context, index) {
          String date = sortedKeys[index];
          Map<String, dynamic> daySchedule = data![date]!;

          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  if (daySchedule.containsKey('Morning'))
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Morning: ${daySchedule['Morning']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  if (daySchedule.containsKey('Afternoon'))
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Afternoon: ${daySchedule['Afternoon']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  if (daySchedule.containsKey('Night'))
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Night: ${daySchedule['Night']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
