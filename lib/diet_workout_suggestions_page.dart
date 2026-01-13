import 'package:flutter/material.dart';

class DietWorkoutSuggestionsPage extends StatelessWidget {
  const DietWorkoutSuggestionsPage({Key? key}) : super(key: key);

  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color accentYellow = Color(0xFFFFC107);

  static const List<String> pcosFriendlyFoods = [
    "Leafy greens (spinach, kale, lettuce)",
    "Berries (blueberries, strawberries)",
    "Nuts and seeds (almonds, chia, flax)",
    "Lean proteins (chicken, fish, tofu)",
    "Whole grains (quinoa, brown rice, oats)",
    "Healthy fats (avocado, olive oil)",
    "Low GI fruits (apples, pears)",
    "Legumes & beans",
    "Greek yogurt",
    "Cruciferous veggies (broccoli, cauliflower)"
  ];

  static const List<Map<String, String>> workoutTips = [
    {
      "title": "Yoga",
      "desc":
      "Yoga helps reduce stress and balance hormones. Try butterfly, cobra and bridge poses."
    },
    {
      "title": "Walking",
      "desc":
      "30 minutes of brisk walking 5 days a week improves insulin sensitivity."
    },
    {
      "title": "Strength Training",
      "desc":
      "Do squats, lunges and wall push-ups 2–3 times a week to build muscle."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      appBar: AppBar(
        title: const Text("Diet & Workout"),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// FOOD SECTION
            const Text(
              "PCOS-friendly Foods",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 12),

            ...pcosFriendlyFoods.map(
                  (food) => Card(
                color: Colors.white,
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: primaryGreen),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          food,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// WORKOUT SECTION
            const Text(
              "Simple Workout Tips",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 12),

            ...workoutTips.map(
                  (tip) => Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: accentYellow.withOpacity(0.2),
                    child: Icon(
                      tip["title"] == "Yoga"
                          ? Icons.self_improvement
                          : tip["title"] == "Walking"
                          ? Icons.directions_walk
                          : Icons.fitness_center,
                      color: primaryGreen,
                    ),
                  ),
                  title: Text(
                    tip["title"] ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(tip["desc"] ?? ""),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// NOTE
            const Text(
              "⚠️ Always consult your doctor or nutritionist before changing diet or exercise routines.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
