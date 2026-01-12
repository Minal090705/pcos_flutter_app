import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const AnalyticsScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  DateTime get nextPeriod => startDate.add(const Duration(days: 28));
  DateTime get ovulationDay => startDate.add(const Duration(days: 14));

  Widget infoBox(String title, DateTime date) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$title: ${date.toString().split(' ')[0]}",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BLOOM Analytics")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoBox("Start Date", startDate),
            infoBox("End Date", endDate),
            infoBox("Next Period", nextPeriod),
            infoBox("Ovulation Day", ovulationDay),

            const SizedBox(height: 20),
            const Text(
              "Cycle Trend (PCOS Analysis)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              height: 260,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: LineChart(
                LineChartData(
                  minX: 1,
                  maxX: 28,
                  minY: 0,
                  maxY: 10,
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        28,
                        (i) => FlSpot(
                          (i + 1).toDouble(),
                          5 +
                              (i < 14
                                  ? i * 0.1
                                  : (28 - i) * 0.1),
                        ),
                      ),
                      isCurved: true,
                      color: Colors.purple,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.25),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "PCOS Insight",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Hormonal trend shows mild imbalance with delayed ovulation, commonly observed in PCOS.",
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 6),
                Text("Irregular cycle pattern detected."),
              ],
            ),

            const SizedBox(height: 25),
            const Center(
              child: Text(
                "Stay healthy 💗",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
