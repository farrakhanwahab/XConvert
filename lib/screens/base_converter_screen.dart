import 'package:flutter/material.dart';
import '../widgets/input.dart';
import '../widgets/dropdown.dart';

abstract class BaseConverterScreen extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const BaseConverterScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  State<BaseConverterScreen> createState();
}

abstract class BaseConverterScreenState<T extends BaseConverterScreen> extends State<T> {
  String fromUnit = '';
  String toUnit = '';
  String input = '';
  String result = '';
  late final TextEditingController inputController;

  // To be implemented by subclasses
  List<String> get units;
  @mustCallSuper
  Future<void> calculateResult();
  String getToUnitFullName();
  
  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    if (units.isNotEmpty) {
      fromUnit = units[0];
      toUnit = units.length > 1 ? units[1] : units[0];
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.iconColor.withAlpha(33),
              child: Icon(widget.icon, color: widget.iconColor),
            ),
            const SizedBox(width: 12),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: widget.iconColor,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppDropdown<String>(
                    label: 'From',
                    value: fromUnit,
                    items: units
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(u, style: Theme.of(context).textTheme.bodyLarge),
                            ))
                        .toList(),
                    onChanged: (val) async {
                      if (val == null) return;
                      setState(() => fromUnit = val);
                      await calculateResult();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.swap_horiz, color: scheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: AppDropdown<String>(
                    label: 'To',
                    value: toUnit,
                    items: units
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(u, style: Theme.of(context).textTheme.bodyLarge),
                            ))
                        .toList(),
                    onChanged: (val) async {
                      if (val == null) return;
                      setState(() => toUnit = val);
                      await calculateResult();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppInput(
              label: 'Enter value',
              controller: inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (val) async {
                if (val.isEmpty || RegExp(r'^\d*\.?\d*$').hasMatch(val)) {
                  setState(() => input = val);
                  await calculateResult();
                }
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Result',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.outline.withAlpha(33)),
              ),
              child: result.isEmpty
                  ? Text('--', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: scheme.onSurface, fontWeight: FontWeight.w600))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(result, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: scheme.onSurface, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(getToUnitFullName(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withAlpha(179))),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 