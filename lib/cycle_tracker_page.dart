import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CycleTrackerPage extends StatefulWidget {
  const CycleTrackerPage({super.key});

  @override
  State<CycleTrackerPage> createState() => _CycleTrackerPageState();
}

class _CycleTrackerPageState extends State<CycleTrackerPage> {
  // 🌸 Bloom Colors
  final Color bloomPurple = const Color(0xFFBA68C8);
  final Color bloomLight = const Color(0xFFF7EDF9);
  final Color textDark = const Color(0xFF3A3A3A);

  // 🩸 Cycle Data
  DateTime? lastPeriodStartDate;
  int? periodLength;
  int? cycleLength;
  String cycleType = 'Regular';

  String flowIntensity = '';

  Map<String, bool> symptoms = {
    'Cramps': false,
    'Headache': false,
    'Back Pain': false,
    'Breast Tenderness': false,
    'Bloating': false,
    'Fatigue': false,
    'Nausea': false,
  };

  final List<String> flowOptions = ['Light', 'Medium', 'Heavy', 'Spotting'];
  final List<int> cycleLengths = [28, 30, 32];
  final List<String> cycleTypes = ['Regular', 'Irregular'];

  DateTime? get nextExpectedPeriodDate {
    if (lastPeriodStartDate != null && cycleLength != null) {
      return lastPeriodStartDate!.add(Duration(days: cycleLength!));
    }
    return null;
  }

  int? get cycleDay {
    if (lastPeriodStartDate != null) {
      return DateTime.now().difference(lastPeriodStartDate!).inDays + 1;
    }
    return null;
  }

  bool get isCycleRegular => cycleType == 'Regular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bloomLight,
      appBar: AppBar(
        backgroundColor: bloomPurple,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Cycle Tracker",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("🗓️ Basic Info"),

            _datePickerRow(),
            _numberInputRow("Period Length (days)", "4-7", (val) {
              periodLength = int.tryParse(val);
            }),
            _cycleLengthRow(),
            _cycleTypeRow(),

            const SizedBox(height: 16),
            _infoText(
                "Next Expected Period: ${nextExpectedPeriodDate == null ? "--" : nextExpectedPeriodDate!.toLocal().toString().split(' ')[0]}"),
            _infoText(
                "Current Cycle Day: ${cycleDay == null ? "--" : "Day $cycleDay"}"),
            _infoText("Is Cycle Regular: ${isCycleRegular ? "Yes" : "No"}"),

            const SizedBox(height: 24),
            _sectionTitle("🩸 Flow Tracking"),
            Wrap(
              spacing: 10,
              children: flowOptions.map((flow) {
                return ChoiceChip(
                  label: Text(flow),
                  selected: flowIntensity == flow,
                  selectedColor: bloomPurple.withOpacity(0.25),
                  labelStyle: TextStyle(
                    color:
                    flowIntensity == flow ? bloomPurple : textDark,
                  ),
                  onSelected: (_) {
                    setState(() {
                      flowIntensity = flow;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            _sectionTitle("🤕 Physical Symptoms"),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: symptoms.keys.map((symptom) {
                return FilterChip(
                  label: Text(symptom),
                  selected: symptoms[symptom]!,
                  selectedColor: bloomPurple.withOpacity(0.25),
                  labelStyle: TextStyle(
                    color: symptoms[symptom]!
                        ? bloomPurple
                        : textDark,
                  ),
                  onSelected: (val) {
                    setState(() {
                      symptoms[symptom] = val;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bloomPurple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Cycle data saved")),
                  );
                },
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 UI Helpers

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: bloomPurple,
        ),
      ),
    );
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        color: textDark,
      ),
    );
  }

  Widget _datePickerRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Last Period Start Date",
            style: GoogleFonts.poppins(),
          ),
        ),
        Text(
          lastPeriodStartDate == null
              ? "--"
              : lastPeriodStartDate!
              .toLocal()
              .toString()
              .split(' ')[0],
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: lastPeriodStartDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                lastPeriodStartDate = picked;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _numberInputRow(
      String label, String hint, Function(String) onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 70,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: hint),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _cycleLengthRow() {
    return Row(
      children: [
        const Expanded(child: Text("Cycle Length")),
        DropdownButton<int>(
          hint: const Text("28"),
          value: cycleLength,
          items: cycleLengths
              .map(
                (len) => DropdownMenuItem(
              value: len,
              child: Text("$len"),
            ),
          )
              .toList(),
          onChanged: (val) {
            setState(() {
              cycleLength = val;
            });
          },
        ),
      ],
    );
  }

  Widget _cycleTypeRow() {
    return Row(
      children: [
        const Expanded(child: Text("Cycle Regularity")),
        DropdownButton<String>(
          value: cycleType,
          items: cycleTypes
              .map(
                (type) => DropdownMenuItem(
              value: type,
              child: Text(type),
            ),
          )
              .toList(),
          onChanged: (val) {
            setState(() {
              cycleType = val!;
              if (cycleType == 'Irregular') cycleLength = null;
            });
          },
        ),
      ],
    );
  }
}
