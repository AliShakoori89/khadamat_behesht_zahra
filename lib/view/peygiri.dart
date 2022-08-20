import 'package:flutter/material.dart';

class Peygiri extends StatelessWidget {
  const Peygiri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("پیگیری",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
