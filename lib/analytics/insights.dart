/// Calculates average cycle length
double calculateAverageCycle(List<int> cycleLengths) {
  if (cycleLengths.isEmpty) return 0;

  final total = cycleLengths.reduce((a, b) => a + b);
  return total / cycleLengths.length;
}

/// Calculates frequency of symptoms
Map<String, int> calculateSymptomFrequency(
    List<List<String>> symptomsList) {
  final Map<String, int> frequency = {};

  for (final symptoms in symptomsList) {
    for (final symptom in symptoms) {
      frequency[symptom] = (frequency[symptom] ?? 0) + 1;
    }
  }

  return frequency;
}
