import 'package:findam/routes/found.dart';
import 'package:findam/routes/home.dart';
import 'package:findam/routes/report.dart';
import 'package:flutter/material.dart';
import 'routes/notifications.dart';
import 'routes/profile.dart';

class HomeScreen extends StatelessWidget {
  final int selectedIndex;

  const HomeScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(initialIndex: selectedIndex);
  }
}

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    FoundItems(),
    ReportItem(),
    Notifications(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.black,
        title: Text(''),
      ),
      backgroundColor: const Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 95,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox_sharp),
              label: 'Found',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFED873D),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          selectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          unselectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(33, 33, 33, 1.0),
          selectedIconTheme: const IconThemeData(size: 24),
          unselectedIconTheme: const IconThemeData(size: 24),
        ),
      ),
    );
  }
}
