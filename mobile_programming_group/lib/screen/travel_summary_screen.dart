import 'package:flutter/material.dart';

import '../service/file_service.dart';
import 'result_screen.dart';

class TravelSummaryPage extends StatelessWidget {
  final String country;
  final String state;
  final String currency;
  final String budget;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String companion;
  final String style;

  TravelSummaryPage({
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Travel Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travel summary:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Country: $country'),
            Text('State: $state'),
            Text('Currency: $currency'),
            Text('Budget: $budget'),
            Text('Departure date: ${departureDate.toLocal().month}/${departureDate.toLocal().day}'),
            Text('Arrival date: ${arrivalDate.toLocal().month}/${arrivalDate.toLocal().day}'),
            Text('Travel companion: $companion'),
            Text('Travel style: $style'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 이전 화면으로 돌아가기
              },
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextProcessingApp(
                      country: country,
                      state: state,
                      currency: currency,
                      budget: budget,
                      departureDate: departureDate,
                      arrivalDate: arrivalDate,
                      companion: companion,
                      style: style,
                    ),
                  ),
                );
              },
              child: Text('Complete'),
            ),
          ],
        ),
      ),
    );
  }
}