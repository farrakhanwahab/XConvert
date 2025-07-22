import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _fontSize = 'Medium';
  String _appName = 'XConvert';
  String _version = '';
  final String _author = 'Farrakhan Wahab';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      setState(() {
        _appName = info.appName;
        _version = info.version;
      });
    } catch (_) {
      // Use defaults
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Font Size', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Small', label: Text('Small')),
              ButtonSegment(value: 'Medium', label: Text('Medium')),
              ButtonSegment(value: 'Large', label: Text('Large')),
            ],
            selected: {_fontSize},
            onSelectionChanged: (Set<String> newSelection) {
              final selected = newSelection.first;
              setState(() => _fontSize = selected);
              double scale;
              switch (selected) {
                case 'Small':
                  scale = 0.9;
                  break;
                case 'Large':
                  scale = 1.15;
                  break;
                case 'Medium':
                default:
                  scale = 1.0;
              }
              ref.read(fontScaleProvider.notifier).setFontScale(scale);
            },
          ),
          const SizedBox(height: 32),
          Text('App Info', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(_appName),
            subtitle: Text('Version $_version'),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Author'),
            subtitle: Text(_author),
          ),
        ],
      ),
    );
  }
} 