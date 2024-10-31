import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TravelOptionsPage extends StatefulWidget {
  final String country;
  final String state;
  final String currency;
  final String budget;
  final DateTime departureDate;
  final DateTime arrivalDate;

  TravelOptionsPage({
    required this.country,
    required this.state,
    required this.currency,
    required this.budget,
    required this.departureDate,
    required this.arrivalDate,
  });

  @override
  _TravelOptionsPageState createState() => _TravelOptionsPageState();
}

class _TravelOptionsPageState extends State<TravelOptionsPage> {
  String? selectedCompanion; // "누구와" 선택된 값
  String? selectedStyle;     // "여행 스타일" 선택된 값

  // 선택 가능한 옵션 리스트
  final List<String> companions = ['혼자', '친구와', '연인과', '배우자와', '아이와', '부모님과', '기타'];
  final List<String> styles = ['체험·액티비티', 'SNS 핫플레이스', '자연과 함께', '유명 관광지는 필수', '여유롭게 힐링', '문화·예술·역사', '여행지 느낌 물씬', '쇼핑은 열정적으로', '관광보다 먹방'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('여행 옵션 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '선택된 여행 정보:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('국가: ${widget.country}'),
            Text('주: ${widget.state}'),
            Text('통화: ${widget.currency}'),
            Text('예산: ${widget.budget}'),
            Text('출발일: ${widget.departureDate.toLocal()}'),
            Text('도착일: ${widget.arrivalDate.toLocal()}'),
            SizedBox(height: 20),
            Text(
              '어떤 스타일의 여행을 할 계획인가요?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('누구와'),
            Wrap(
              spacing: 8,
              children: companions.map((companion) {
                return ChoiceChip(
                  label: Text(companion),
                  selected: selectedCompanion == companion,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedCompanion = isSelected ? companion : null;
                    });
                  },
                  selectedColor: Colors.blue,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('여행 스타일'),
            Wrap(
              spacing: 8,
              children: styles.map((style) {
                return ChoiceChip(
                  label: Text(style),
                  selected: selectedStyle == style,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedStyle = isSelected ? style : null;
                    });
                  },
                  selectedColor: Colors.blue,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (selectedCompanion != null && selectedStyle != null) ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TravelSummaryPage(
                      country: widget.country,
                      state: widget.state,
                      currency: widget.currency,
                      budget: widget.budget,
                      departureDate: widget.departureDate,
                      arrivalDate: widget.arrivalDate,
                      companion: selectedCompanion!,
                      style: selectedStyle!,
                    ),
                  ),
                );
              } : null,
              child: Text('완료'),
            ),
          ],
        ),
      ),
    );
  }
}




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
      appBar: AppBar(title: Text('여행 요약')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '여행 요약:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('국가: $country'),
            Text('주: $state'),
            Text('통화: $currency'),
            Text('예산: $budget'),
            Text('출발일: ${departureDate.toLocal()}'),
            Text('도착일: ${arrivalDate.toLocal()}'),
            Text('여행 동반자: $companion'),
            Text('여행 스타일: $style'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 이전 화면으로 돌아가기
              },
              child: Text('돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}
