import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../l10n/app_localizations.dart';

class SoilHealthPage extends StatefulWidget {
  const SoilHealthPage({super.key});

  @override
  State<SoilHealthPage> createState() => _SoilHealthPageState();
}

class _SoilHealthPageState extends State<SoilHealthPage> {
  final TextEditingController phController = TextEditingController();
  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();

  String recommendation = "";
  Map<String, int> nutrientLevels = {"N": 0, "P": 0, "K": 0};

  void analyzeSoil(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    double? ph = double.tryParse(phController.text);
    int? n = int.tryParse(nController.text);
    int? p = int.tryParse(pController.text);
    int? k = int.tryParse(kController.text);

    if (ph == null || n == null || p == null || k == null) {
      setState(() {
        recommendation = l10n.invalidValues;
      });
      return;
    }

    nutrientLevels = {"N": n, "P": p, "K": k};

    if (ph < 5.5) {
      recommendation = l10n.acidicSoil;
    } else if (ph > 7.5) {
      recommendation = l10n.alkalineSoil;
    } else {
      recommendation = l10n.goodSoil;
    }

    if (n < 50) recommendation += "\n${l10n.addN}";
    if (p < 50) recommendation += "\n${l10n.addP}";
    if (k < 50) recommendation += "\n${l10n.addK}";

    if (n >= 50 && p >= 50 && k >= 50) {
      recommendation += "\n${l10n.balancedNPK}";
    }

    setState(() {});
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.soilHealthTitle),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.enterValues,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: phController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(l10n.phLabel),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(l10n.nLabel),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(l10n.pLabel),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: kController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(l10n.kLabel),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => analyzeSoil(context),
              icon: const Icon(Icons.science),
              label: Text(l10n.analyzeButton),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Chart
            if (recommendation.isNotEmpty)
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final titles = [l10n.nLabel, l10n.pLabel, l10n.kLabel];
                            final text = titles[value.toInt()];
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(text, style: theme.textTheme.bodySmall),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                              toY: nutrientLevels["N"]!.toDouble(),
                              width: 20,
                              color: Colors.blue),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                              toY: nutrientLevels["P"]!.toDouble(),
                              width: 20,
                              color: Colors.red),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                              toY: nutrientLevels["K"]!.toDouble(),
                              width: 20,
                              color: Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Recommendations
            if (recommendation.isNotEmpty)
              Card(
                color: theme.colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(recommendation, style: theme.textTheme.bodyLarge),
                ),
              ),
            const SizedBox(height: 20),

            // Best Practices
            Text(l10n.bestPractices,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ${l10n.practice1}"),
                    Text("• ${l10n.practice2}"),
                    Text("• ${l10n.practice3}"),
                    Text("• ${l10n.practice4}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
