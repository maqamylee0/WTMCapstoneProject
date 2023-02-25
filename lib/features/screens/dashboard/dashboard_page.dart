import 'package:dartfri/features/screens/account/account_page.dart';
import 'package:dartfri/features/screens/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bookings/bookings_page.dart';

class DashboardPage extends StatefulWidget {

   DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:  IndexedStack(
          children: [
            BookingsPage(),
             HomePage(),
            AccountPage()

          ],
          index: _currentIndex,
        ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items:  [
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.book,
                // FontAwesomeIcons.book,
                color: Colors.black,
              ),
              label: "Bookings"),
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.car_detailed,
                color: Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.settings_solid,
                // FontAwesomeIcons.,
                color: Colors.black,
              ),
              label: "Profile"),

        ],
      ),
    ));
  }
}
