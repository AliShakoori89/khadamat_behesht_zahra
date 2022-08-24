import 'package:flutter/material.dart';
import 'package:khadamat_behesht_zahra/presentation/services_icons.dart';
import 'package:khadamat_behesht_zahra/view/Akhbar.dart';
import 'package:khadamat_behesht_zahra/view/arzesh_afzoode.dart';
import 'package:khadamat_behesht_zahra/view/home_page/network/services_from_network.dart';
import 'package:khadamat_behesht_zahra/view/motevafiyan.dart';
import 'package:khadamat_behesht_zahra/view/peygiri.dart';

class HomePageNetwork extends StatefulWidget {
  const HomePageNetwork({Key? key}) : super(key: key);

  @override
  State<HomePageNetwork> createState() => _HomePageNetworkState();
}

class _HomePageNetworkState extends State<HomePageNetwork> {

  int _selectedIndex = 2;

  final List<Widget> _children = [
    const ArzeshAfzoode(),
    const Peygiri(),
    const ServicesFromNetwork(),
    const Motevafiyan(),
    const Akhbar()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.contacts, color: Colors.grey,),
              label: 'ارزش افزوده',
              backgroundColor: Colors.grey[300]
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.content_paste_search, color: Colors.grey),
              label: 'پیگیزی',
              backgroundColor: Colors.grey[300]
          ),
          BottomNavigationBarItem(
              icon: const Icon(ServicesIcon.layers, color: Colors.grey),
              label: 'خذمات',
              backgroundColor: Colors.grey[300]
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/image/tomb_icon.png",
                width: 35,
                color: Colors.grey,),
              label: 'متوفیان',
              backgroundColor: Colors.grey[300]
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.newspaper, color: Colors.grey),
              label: 'اخبار',
              backgroundColor: Colors.grey[300]
          ),
        ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5),
        body: _children[_selectedIndex]
    );
  }
}
