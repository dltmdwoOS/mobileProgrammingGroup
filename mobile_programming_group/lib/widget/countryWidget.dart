import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamproject/widget/budgetWidget.dart';



class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('위치 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CSCPicker(

              ///기본 옵션 설정
              showStates: true,
              showCities: false,
              flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

              /// 선택된 값들을 각 변수에 저장
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value ?? "";
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value ?? "";
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (countryValue.isNotEmpty && stateValue.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Budgetwidget(
                        country: countryValue,
                        state: stateValue,
                      ),
                    ),
                  );
                }
              },
              child: Text('위치 확인'),
            ),
          ],
        ),
      ),
    );
  }
}