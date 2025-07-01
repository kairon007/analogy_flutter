import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import 'screens/create_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/you_screen.dart';
import 'notifiers/app_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppNotifier(),
      child: const AnalogyApp(),
    ),
  );
}

class AnalogyApp extends StatelessWidget {
  const AnalogyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analogy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CreateScreen(),
    ExploreScreen(),
    SavedScreen(),
    YouScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.bookOpen),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.heart),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.settings),
            label: 'You',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF8B7355),
        unselectedItemColor: const Color(0xFFA0A0A0),
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFFAF7F2),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}