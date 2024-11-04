import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../widget/currencyWidget.dart';
import 'calendar_screen.dart';

class Budgetwidget extends StatefulWidget {
  final String planName;
  final String country;
  final String state;

  Budgetwidget({required this.planName, required this.country, required this.state});

  @override
  _Budgetwidget createState() => _Budgetwidget();
}

class _Budgetwidget extends State<Budgetwidget> {
  TextEditingController budgetController = TextEditingController();
  String? selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected travel details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Country: ${widget.country}'),
            Text('State: ${widget.state}'),
            SizedBox(height: 20),

            // 통화 선택 버튼
            ElevatedButton(
              onPressed: () {
                showCustomCurrencyPicker(
                  context,
                      (selectedCurrencyCode) {
                    setState(() {
                      selectedCurrency = selectedCurrencyCode;
                    });
                  },
                );
              },
              child: Text(selectedCurrency == null
                  ? 'Select Currency'
                  : 'Selected Currency: $selectedCurrency'),
            ),

            SizedBox(height: 20),
            Text(
              'Enter Budget:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // 예산 입력 필드
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Budget',
                border: OutlineInputBorder(),
              ),
              enabled: selectedCurrency != null, // 통화 선택 후 활성화
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                String budget = budgetController.text;
                if (budget.isNotEmpty && selectedCurrency != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarPage(
                        planName: widget.planName,
                        country: widget.country,
                        state: widget.state,
                        currency: selectedCurrency!,
                        budget: budget,
                      ),
                    ),
                  );
                }
              },
              child: Text('Check budget'),
            ),
          ],
        ),
      ),
    );
  }
}
