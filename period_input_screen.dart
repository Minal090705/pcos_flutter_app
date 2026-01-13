import 'package:flutter/material.dart';
import 'analytics_screen.dart';

class PeriodInputScreen extends StatefulWidget {
  const PeriodInputScreen({super.key});

  @override
  State<PeriodInputScreen> createState() => _PeriodInputScreenState();
}

class _PeriodInputScreenState extends State<PeriodInputScreen> {
  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        isStart ? startDate = picked : endDate = picked;
      });
    }
  }

  Widget dateBox(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date == null
                  ? label
                  : "$label: ${date.toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_month, color: Colors.purple),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Period Input")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            dateBox("Start Date", startDate, () => pickDate(true)),
            dateBox("End Date", endDate, () => pickDate(false)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: startDate != null && endDate != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnalyticsScreen(
                      startDate: startDate!,
                      endDate: endDate!,
                    ),
                  ),
                );
              }
                  : null,
              child: const Text("View Analytics"),
            ),
          ],
        ),
      ),
    );
  }
}
