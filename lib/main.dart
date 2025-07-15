import 'package:analogy_flutter/screens/create/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';
import 'notifiers/localization_provider.dart';

import 'screens/explore_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/you_screen.dart';
import 'notifiers/app_notifier.dart';
import 'providers/user_settings_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppNotifier>(create: (_) => AppNotifier()),
        ChangeNotifierProvider<LocalizationProvider>(create: (_) => LocalizationProvider(prefs)),
        ChangeNotifierProvider<UserSettingsProvider>(create: (_) => UserSettingsProvider(prefs)),

      ],
      child: const AnalogyApp(),
    ),
  );
}

class AnalogyApp extends StatelessWidget {
  const AnalogyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.watch<LocalizationProvider>().locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
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
