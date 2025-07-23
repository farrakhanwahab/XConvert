import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xconvert/app_theme.dart';
import 'package:xconvert/screens/history_chart_screen.dart';
import 'package:xconvert/screens/home_screen.dart';
import 'package:xconvert/widgets/app_drawer.dart';
import 'package:xconvert/screens/splash_screen.dart';

final fontScaleProvider =
    StateNotifierProvider<FontScaleNotifier, double>((ref) {
  return FontScaleNotifier();
});

class FontScaleNotifier extends StateNotifier<double> {
  static const _key = 'fontScale';
  FontScaleNotifier() : super(1.0) {
    _load();
  }
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getDouble(_key) ?? 1.0;
  }

  Future<void> setFontScale(double scale) async {
    state = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key, scale);
  }
}

void main() {
  runApp(const ProviderScope(child: XConvertApp()));
}

class XConvertApp extends ConsumerWidget {
  const XConvertApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontScale = ref.watch(fontScaleProvider);
    return MaterialApp(
      title: 'XConvert',
      theme: AppTheme.lightTheme(fontScale),
      darkTheme: AppTheme.darkTheme(fontScale),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScaffold(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const HomeScreen(),
    const HistoryChartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'XConvert' : 'Currency History'),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      drawer: AppDrawer(onPageSelected: _onItemTapped),
      body: _pages[_selectedIndex],
    );
  }
}
