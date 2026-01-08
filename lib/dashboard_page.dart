import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'setting_page.dart';
import 'health_profile_page.dart';

class DashboardPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const DashboardPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // 🌸 Bloom Colors
  static const Color bloomPurple = Color(0xFF7B1FA2);
  static const Color bloomLavender = Color(0xFFF3E5F5);

  // 🩸 USER DATA (CUSTOMIZABLE)
  final DateTime lastPeriodDate = DateTime(2025, 9, 1); // change here
  final int cycleLength = 32; // 👈 CUSTOM CYCLE LENGTH (28–35)

  // 🔹 CURRENT CYCLE DAY
  int get currentDay {
    final daysPassed =
        DateTime.now().difference(lastPeriodDate).inDays;
    return (daysPassed % cycleLength) + 1;
  }

  // 🔹 PROGRESS
  double get cycleProgress => currentDay / cycleLength;

  // 🔹 PHASE CALCULATION
  String get cyclePhase {
    if (currentDay <= 5) return "Menstrual Phase";
    if (currentDay <= 13) return "Follicular Phase";
    if (currentDay <= 16) return "Ovulation Phase";
    return "Luteal Phase";
  }

  // 🔹 PHASE ICON
  IconData get phaseIcon {
    if (cyclePhase == "Menstrual Phase") return Icons.water_drop;
    if (cyclePhase == "Follicular Phase") return Icons.local_florist;
    if (cyclePhase == "Ovulation Phase") return Icons.favorite;
    return Icons.self_improvement;
  }

  // 🔹 NEXT PERIOD PREDICTION
  DateTime get nextPeriodDate =>
      lastPeriodDate.add(Duration(days: cycleLength));

  int get daysLeftForPeriod =>
      nextPeriodDate.difference(DateTime.now()).inDays;

  String formatDate(DateTime date) =>
      "${date.day}/${date.month}/${date.year}";

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: bloomPurple, size: 28),
            const SizedBox(height: 12),
            Text(title,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: bloomLavender,
        child: Icon(icon, color: bloomPurple),
      ),
      title: Text(title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bloomLavender,
      appBar: AppBar(
        backgroundColor: bloomPurple,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Bloom',
          style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    isDarkMode: widget.isDarkMode,
                    onThemeChanged: widget.onThemeChanged,
                  ),
                ),
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good to see you 🌸',
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: bloomPurple)),
            const SizedBox(height: 6),
            Text('Your cycle is auto-calculated',
                style: GoogleFonts.poppins(color: Colors.grey)),

            const SizedBox(height: 20),

            // 🌼 CYCLE RING
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: bloomPurple.withOpacity(0.2),
                        blurRadius: 20),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 190,
                      height: 190,
                      child: CircularProgressIndicator(
                        value: cycleProgress,
                        strokeWidth: 14,
                        backgroundColor: bloomLavender,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(bloomPurple),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(phaseIcon,
                            color: bloomPurple, size: 32),
                        const SizedBox(height: 6),
                        Text("Day $currentDay",
                            style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: bloomPurple)),
                        Text(cyclePhase,
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📅 NEXT PERIOD CARD (NEW FEATURE)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: ListTile(
                leading: Icon(Icons.calendar_month,
                    color: bloomPurple),
                title: Text(
                  "Next Period Expected",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "${formatDate(nextPeriodDate)} • $daysLeftForPeriod days left",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                _infoCard(
                    icon: Icons.favorite,
                    title: 'Symptoms',
                    subtitle: '3 tracked'),
                const SizedBox(width: 12),
                _infoCard(
                    icon: Icons.bedtime,
                    title: 'Sleep',
                    subtitle: '7 hrs'),
              ],
            ),

            const SizedBox(height: 24),

            Text('Quick Actions',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              elevation: 8,
              child: Column(
                children: [
                  _actionTile(
                      icon: Icons.edit,
                      title: 'Log Today’s Symptoms'),
                  const Divider(height: 0),
                  _actionTile(
                    icon: Icons.person,
                    title: 'View Health Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const HealthProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
