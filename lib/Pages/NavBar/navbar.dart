import 'package:festimatch/Pages/NavBar/calendar.dart';
import 'package:festimatch/Pages/NavBar/home.dart';
import 'package:festimatch/Pages/NavBar/profil.dart';
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _index = 0;

  final screens = [
    HomePage(),
    CalendarPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[_index],
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: primaryColor,
        selectedBackgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        padding: EdgeInsets.all(4),
        onTap: (int val) => setState(() => _index = val),
        currentIndex: _index,
        items: [
          FloatingNavbarItem(customWidget: Icon(LucideIcons.house, color: _index==0 ? primaryColor : textColor,)),
          FloatingNavbarItem(customWidget: Icon(LucideIcons.calendar, color: _index==1 ? primaryColor : textColor,)),
          FloatingNavbarItem(customWidget: Icon(LucideIcons.user, color: _index==2 ? primaryColor : textColor,)),
        ],
      ),
    );
  }
}