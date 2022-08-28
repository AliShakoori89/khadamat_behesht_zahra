import 'package:flutter/material.dart';
import 'package:khadamat_behesht_zahra/presentation/services_icons.dart';
import 'package:khadamat_behesht_zahra/view/Akhbar.dart';
import 'package:khadamat_behesht_zahra/view/arzesh_afzoode.dart';
import 'package:khadamat_behesht_zahra/view/home_page/database/services_from_database.dart';
import 'package:khadamat_behesht_zahra/view/motevafiyan.dart';
import 'package:khadamat_behesht_zahra/view/peygiri.dart';

class HomePageDatabase extends StatefulWidget {
  const HomePageDatabase({Key? key}) : super(key: key);

  @override
  State<HomePageDatabase> createState() => _HomePageDatabaseState();
}

class _HomePageDatabaseState extends State<HomePageDatabase> {

  int _selectedIndex = 2;

  final List<Widget> _children = [
    const ArzeshAfzoode(),
    const Peygiri(),
    const ServicesFromDatabase(),
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
              const BottomNavigationBarItem(
                  icon: Icon(Icons.contacts,
                    color: Colors.white,),
                  label: 'ارزش افزوده',
                  backgroundColor: Colors.white10
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.content_paste_search,
                      color: Colors.white),
                  label: 'پیگیزی',
                  backgroundColor: Colors.white10
              ),
              const BottomNavigationBarItem(
                  icon: Icon(ServicesIcon.layers,
                      color: Colors.white),
                  label: 'خذمات',
                  backgroundColor: Colors.white10
              ),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/image/tomb_icon.png",
                    width: 35,
                    color: Colors.white,),
                  label: 'متوفیان',
                  backgroundColor: Colors.white10
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper,
                      color: Colors.white),
                  label: 'اخبار',
                  backgroundColor: Colors.white10
              ),
            ],
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.green,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 5),
        body: _children[_selectedIndex]
    );
  }
}
