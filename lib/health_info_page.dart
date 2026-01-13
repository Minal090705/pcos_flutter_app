import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_page.dart';

class HealthInfoPage extends StatefulWidget {
  const HealthInfoPage({super.key});

  @override
  State<HealthInfoPage> createState() => _HealthInfoPageState();
}

class _HealthInfoPageState extends State<HealthInfoPage> {
  // Bloom colors
  static const Color bloomPurple = Color(0xFF7B1FA2);
  static const Color bloomLavender = Color(0xFFF3E5F5);

  // Symptoms
  bool _acne = false;
  bool _hairFall = false;
  bool _cramps = false;

  // Lifestyle
  String _lifestyle = 'Sedentary';

  // Diet
  String _dietPreference = 'Veg';

  // Workout
  int _workoutFrequency = 0;

  // Sleep
  double _sleepHours = 7.0;

  // Stress
  int _stressLevel = 3;

  // Medication
  final TextEditingController _medicationController =
  TextEditingController();

  @override
  void dispose() {
    _medicationController.dispose();
    super.dispose();
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: bloomPurple,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bloomPurple,
        centerTitle: true,
        title: Text(
          'Health Information',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bloomLavender, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 10,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Symptoms'),
                  CheckboxListTile(
                    activeColor: bloomPurple,
                    title: const Text('Acne'),
                    value: _acne,
                    onChanged: (v) => setState(() => _acne = v!),
                  ),
                  CheckboxListTile(
                    activeColor: bloomPurple,
                    title: const Text('Hair Fall'),
                    value: _hairFall,
                    onChanged: (v) => setState(() => _hairFall = v!),
                  ),
                  CheckboxListTile(
                    activeColor: bloomPurple,
                    title: const Text('Cramps'),
                    value: _cramps,
                    onChanged: (v) => setState(() => _cramps = v!),
                  ),

                  _sectionTitle('Lifestyle'),
                  RadioListTile(
                    activeColor: bloomPurple,
                    title: const Text('Sedentary'),
                    value: 'Sedentary',
                    groupValue: _lifestyle,
                    onChanged: (v) => setState(() => _lifestyle = v!),
                  ),
                  RadioListTile(
                    activeColor: bloomPurple,
                    title: const Text('Active'),
                    value: 'Active',
                    groupValue: _lifestyle,
                    onChanged: (v) => setState(() => _lifestyle = v!),
                  ),

                  _sectionTitle('Diet Preference'),
                  RadioListTile(
                    activeColor: bloomPurple,
                    title: const Text('Vegetarian'),
                    value: 'Veg',
                    groupValue: _dietPreference,
                    onChanged: (v) => setState(() => _dietPreference = v!),
                  ),
                  RadioListTile(
                    activeColor: bloomPurple,
                    title: const Text('Non-Vegetarian'),
                    value: 'Non-Veg',
                    groupValue: _dietPreference,
                    onChanged: (v) => setState(() => _dietPreference = v!),
                  ),

                  _sectionTitle('Workout Frequency (days/week)'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _workoutFrequency > 0
                            ? () => setState(() => _workoutFrequency--)
                            : null,
                      ),
                      Text(
                        '$_workoutFrequency',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            setState(() => _workoutFrequency++),
                      ),
                    ],
                  ),

                  _sectionTitle('Sleep Hours'),
                  Slider(
                    activeColor: bloomPurple,
                    value: _sleepHours,
                    min: 0,
                    max: 12,
                    divisions: 24,
                    label: '${_sleepHours.toStringAsFixed(1)} h',
                    onChanged: (v) => setState(() => _sleepHours = v),
                  ),

                  _sectionTitle('Stress Level'),
                  Slider(
                    activeColor: bloomPurple,
                    value: _stressLevel.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: '$_stressLevel',
                    onChanged: (v) =>
                        setState(() => _stressLevel = v.round()),
                  ),

                  _sectionTitle('Medication'),
                  TextField(
                    controller: _medicationController,
                    decoration: InputDecoration(
                      hintText: 'List medications (if any)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                        const BorderSide(color: bloomPurple, width: 2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bloomPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => DashboardPage(
                          isDarkMode: false,
                          onThemeChanged: (value) {},
                            ),
                            ),
                        );
                      },
                      child: Text(
                        'Save & Continue',
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
          ),
        ),
      ),
    );
  }
}
