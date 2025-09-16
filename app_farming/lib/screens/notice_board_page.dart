import 'package:flutter/material.dart';

class NoticeBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notice Board")),
      body: Center(
        child: Text("Govt initiatives, schemes, and app updates."),
      ),
    );
  }
}
