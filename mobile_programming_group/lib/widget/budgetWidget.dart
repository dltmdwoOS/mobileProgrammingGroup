import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamproject/widget/currencyWidget.dart';


class Budgetwidget extends StatefulWidget {
  final String country;
  final String state;

  Budgetwidget({required this.country, required this.state});

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
        title: Text('위치 상세 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '선택된 위치:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('국가: ${widget.country}'),
            Text('주: ${widget.state}'),
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
                  ? '통화 선택'
                  : '선택된 통화: $selectedCurrency'),

            ),

            SizedBox(height: 20),
            Text(
              '예산 입력:',
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
                labelText: '예산',
                border: OutlineInputBorder(),
              ),
              enabled: selectedCurrency != null, // 통화 선택 후 활성화
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                String budget = budgetController.text;
                if (budget.isNotEmpty && selectedCurrency != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('입력된 정보'),
                        content: Text(
                            '국가: ${widget.country}\n주: ${widget.state}\n통화: $selectedCurrency\n예산: $budget'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('입력 정보 확인'),
            ),
          ],
        ),
      ),
    );
  }
}
