import 'package:flutter/material.dart';
import 'screen/select_location_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // 플러스 아이콘 클릭 시 CscPickerScreen으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectLocationScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
