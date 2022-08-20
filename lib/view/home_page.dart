import 'package:flutter/material.dart';
import 'package:khadamat_behesht_zahra/presentation/google_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("درخواست آنلاین خدمات بهشت زهرا(س)",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        actions: [

        ],
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Google.basket),
        ),
      ),
    );
  }
}
