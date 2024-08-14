import 'package:flutter/material.dart';
import 'main.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Mới'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Text('Đây là trang mới'),
      ),
    );
  }
}

