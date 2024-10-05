import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/views/home/home_view.dart';
import 'package:geoquest/src/views/home/leaderboard_view.dart';
import 'package:geoquest/src/views/home/settings_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _views = [
    const HomeView(),
    const LeaderboardView(),
    const SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_24_regular),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.data_usage_20_regular),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.settings_24_regular),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
