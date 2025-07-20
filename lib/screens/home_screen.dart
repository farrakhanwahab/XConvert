import 'package:flutter/material.dart';
import '../widgets/x_card.dart';
import '../app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final categories = [
      {
        'title': 'Currency',
        'icon': Icons.currency_exchange,
        'color': scheme.surface,
        'iconColor': Colors.blueAccent,
        'type': 'currency',
        'desc': 'Convert between 150+ world currencies with live rates.',
      },
      {
        'title': 'Length',
        'icon': Icons.straighten,
        'color': scheme.surface,
        'iconColor': Colors.green,
        'type': 'length',
        'desc': 'Meters, feet, inches, and more.',
      },
      {
        'title': 'Weight',
        'icon': Icons.monitor_weight,
        'color': scheme.surface,
        'iconColor': Colors.brown,
        'type': 'weight',
        'desc': 'Kilograms, pounds, ounces, and more.',
      },
      {
        'title': 'Temperature',
        'icon': Icons.thermostat,
        'color': scheme.surface,
        'iconColor': Colors.deepOrangeAccent,
        'type': 'temperature',
        'desc': 'Celsius, Fahrenheit, Kelvin, and more.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unit Converter',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
      ),
      body: Container(
        color: scheme.surface,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 24),
          itemBuilder: (context, i) {
            final c = categories[i];
            return CategoryCard(
              icon: c['icon'] as IconData,
              label: c['title'] as String,
              color: c['color'] as Color,
              iconColor: c['iconColor'] as Color,
              description: c['desc'] as String,
              onTap: () {
                // TODO: Navigate to category screen
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final String description;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return XCard(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withAlpha(33),
              radius: 38,
              child: Icon(icon, color: iconColor, size: 38),
            ),
            const SizedBox(width: 28),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: scheme.onSurface.withAlpha(179),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 