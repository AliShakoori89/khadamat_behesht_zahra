import 'package:flutter/material.dart';

class Akhbar extends StatelessWidget {
  const Akhbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("اخبار",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}