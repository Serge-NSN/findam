import 'package:findam/routes/home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomNavBar();
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFAFAFA));
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(
      'Found Items',
      style: optionStyle,
    ),
    Text(
      'Report a Missing Item',
      style: optionStyle,
    ),
    Text(
      'Notifications',
      style: optionStyle,
    ),
    // Add a fifth navigation item for "Profile"
    Text(
      'Setup Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 95, //height of navbar
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
              icon: Icon(Icons.account_circle_outlined), // Add a profile icon
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFED873D),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true, // Make icon labels visible
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
