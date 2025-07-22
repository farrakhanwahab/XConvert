import 'package:flutter/material.dart';
import 'package:xconvert/screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final void Function(int) onPageSelected;

  const AppDrawer({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'XConvert',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onPageSelected(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_outlined),
            title: const Text('Currency History'),
            onTap: () {
              Navigator.pop(context);
              onPageSelected(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 