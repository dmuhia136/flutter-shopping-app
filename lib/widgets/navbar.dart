import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/constants/colors.dart';
import 'package:sales_app/screens/chat.dart';
import 'package:sales_app/screens/homescreen.dart';
import 'package:sales_app/screens/messages.dart';
import 'package:sales_app/screens/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

    int _selectedIndex = 0;  
  static  List<Widget> _widgetOptions = <Widget>[  
   HomeScreen(),  
   Profile(),
   Messages()
  ];  
  
  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  
  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      backgroundColor: CustomColors().primary,
      onTap:_onItemTapped,
      currentIndex: _selectedIndex,
      items: [
        FloatingNavbarItem(icon: Icons.home, title: 'Home'),
        FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
        FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
      ],
    );
  }
}
