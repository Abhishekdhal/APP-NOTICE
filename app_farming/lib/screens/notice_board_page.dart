import 'package:flutter/material.dart';

class NoticeBoardPage extends StatelessWidget {
  const NoticeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notice Board")),
      body: const Center(
        child: Text("Govt initiatives, schemes, and app updates."),
      ),
    );
  }
}
