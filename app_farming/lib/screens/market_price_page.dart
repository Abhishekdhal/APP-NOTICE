import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../l10n/app_localizations.dart';

class MarketPricePage extends StatelessWidget {
  const MarketPricePage({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      "name": "Urea (50 kg)",
      "icon": Icons.grass,
      "amazon": 600,
      "flipkart": 620,
      "mandi": 590,
      "trend": [580, 590, 595, 600, 590],
      "type": "Fertilizers",
    },
    {
      "name": "DAP (50 kg)",
      "icon": Icons.local_florist,
      "amazon": 1200,
      "flipkart": 1180,
      "mandi": 1150,
      "trend": [1100, 1120, 1150, 1170, 1150],
      "type": "Fertilizers",
    },
    {
      "name": "Wheat Seeds (1 kg)",
      "icon": Icons.grain,
      "amazon": 50,
      "flipkart": 55,
      "mandi": 45,
      "trend": [40, 42, 45, 47, 45],
      "type": "Seeds",
    },
    {
      "name": "Pesticide Spray 1L",
      "icon": Icons.sanitizer,
      "amazon": 250,
      "flipkart": 240,
      "mandi": 230,
      "trend": [220, 225, 230, 235, 230],
      "type": "Sprays",
    },
    {
      "name": "Zinc Nutrient (1 kg)",
      "icon": Icons.science,
      "amazon": 150,
      "flipkart": 155,
      "mandi": 140,
      "trend": [135, 140, 145, 150, 140],
      "type": "Nutrients",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface.withOpacity(0.95),
        appBar: AppBar(
          title: Text(
            l10n.marketTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: theme.colorScheme.primary,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.secondary, theme.colorScheme.tertiary],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                labelColor: theme.colorScheme.onPrimary,
                unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(0.7),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                tabs: [
                  Tab(text: l10n.tabFertilizers),
                  Tab(text: l10n.tabSeeds),
                  Tab(text: l10n.tabSprays),
                  Tab(text: l10n.tabNutrients),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildDashboard(context, "Fertilizers"),
            _buildDashboard(context, "Seeds"),
            _buildDashboard(context, "Sprays"),
            _buildDashboard(context, "Nutrients"),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, String type) {
    final filteredProducts =
        products.where((product) => product['type'] == type).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...filteredProducts.map((product) => _buildProductCard(context, product)),
          if (filteredProducts.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildTrendChart(context, filteredProducts),
          ],
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final best = _getBestOption(product);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.surface, theme.colorScheme.surface.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: theme.shadowColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 6))
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(product['icon'], color: theme.colorScheme.onPrimaryContainer),
        ),
        title: Text(product['name'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _priceTile(l10n.amazon, product['amazon'], best == "Amazon", theme),
            _priceTile(l10n.flipkart, product['flipkart'], best == "Flipkart", theme),
            _priceTile(l10n.mandi, product['mandi'], best == "Mandi", theme),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: best == "Mandi"
                ? theme.colorScheme.tertiaryContainer
                : (best == "Amazon"
                    ? theme.colorScheme.secondaryContainer
                    : theme.colorScheme.primaryContainer),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "${l10n.bestLabel}: ${_getLocalizedBest(l10n, best)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: best == "Mandi"
                  ? theme.colorScheme.onTertiaryContainer
                  : (best == "Amazon"
                      ? theme.colorScheme.onSecondaryContainer
                      : theme.colorScheme.onPrimaryContainer),
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceTile(String label, int price, bool highlight, ThemeData theme) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        Text(
          "₹$price",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: highlight ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: highlight ? 14 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendChart(BuildContext context, List<Map<String, dynamic>> filteredProducts) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: theme.shadowColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 6))
        ],
      ),
      child: SizedBox(
        height: 250,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true, horizontalInterval: 50),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      l10n.day(value.toInt() + 1),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: filteredProducts.map((product) {
              return LineChartBarData(
                spots: _mapTrend(product['trend']),
                isCurved: true,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                gradient: LinearGradient(colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ]),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _mapTrend(List<int> trend) {
    return List.generate(trend.length, (i) => FlSpot(i.toDouble(), trend[i].toDouble()));
  }

  String _getBestOption(Map<String, dynamic> product) {
    int amazon = product['amazon'];
    int flipkart = product['flipkart'];
    int mandi = product['mandi'];

    int minPrice = [amazon, flipkart, mandi].reduce((a, b) => a < b ? a : b);

    if (minPrice == mandi) return "Mandi";
    if (minPrice == amazon) return "Amazon";
    return "Flipkart";
  }

  String _getLocalizedBest(AppLocalizations l10n, String best) {
    switch (best) {
      case "Amazon":
        return l10n.amazon;
      case "Flipkart":
        return l10n.flipkart;
      case "Mandi":
        return l10n.mandi;
      default:
        return best;
    }
  }
}
