import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CycleChart extends StatelessWidget {
  const CycleChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 1,
        maxX: 28,
        minY: 0,
        maxY: 10,
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 7,
              getTitlesWidget: (value, meta) {
                return Text('Day ${value.toInt()}');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        extraLinesData: ExtraLinesData(
          verticalLines: [
            VerticalLine(
              x: 14,
              color: Colors.green.withOpacity(0.3),
              strokeWidth: 30,
            ),
          ],
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              28,
                  (i) => FlSpot(i + 1, 5 + (i < 14 ? i * 0.1 : (28 - i) * 0.1)),
            ),
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.purple.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
