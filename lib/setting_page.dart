import 'package:flutter/material.dart';
import 'bloom_login_page.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  // Bloom color palette
  static const primaryColor = Color(0xFFC084D9);
  static const accentColor = Color(0xFFF4C2E8);
  static const textColor = Color(0xFF6A1B9A);
  static const bgColor = Color(0xFFFDF4FA);

  bool isDarkMode = false;
  bool isPeriodReminderOn = true;
  bool isMedsReminderOn = false;
  bool isDailyCheckReminderOn = true;
  String language = 'English';
  int cycleLength = 28;
  bool isRegularCycle = true;
  bool isPCOSDiagnosed = false;
  String weightUnit = 'kg';
  String heightUnit = 'cm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Account
            _sectionHeader(Icons.person, "Account"),
            _tile(Icons.account_circle_outlined, "Edit Profile",
                subtitle: "Update name, age, height, weight"),
            _tile(Icons.lock_outline, "Change Password"),
            _dangerTile(Icons.logout, "Logout"),

            // Preferences
            _sectionHeader(Icons.settings, "Preferences"),
            SwitchListTile(
              activeColor: primaryColor,
              secondary: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode_outlined,
                color: textColor,
              ),
              title: const Text("Dark Mode"),
              value: widget.isDarkMode,
              onChanged: (val) {
                widget.onThemeChanged(val);
              },
            ),

            ExpansionTile(
              leading: const Icon(Icons.notifications_none_outlined,
                  color: textColor),
              title: const Text("Notifications"),
              children: [
                _switchTile("Period reminders", isPeriodReminderOn,
                        (v) => setState(() => isPeriodReminderOn = v)),
                _switchTile("Medication reminders", isMedsReminderOn,
                        (v) => setState(() => isMedsReminderOn = v)),
                _switchTile("Daily check-in reminders",
                    isDailyCheckReminderOn,
                        (v) => setState(() => isDailyCheckReminderOn = v)),
              ],
            ),

            _tile(Icons.language_outlined, "Language", subtitle: language),

            // Health
            _sectionHeader(Icons.favorite, "Health"),
            _tile(Icons.sync, "Cycle Length",
                subtitle: "$cycleLength days"),
            SwitchListTile(
              activeColor: primaryColor,
              secondary: const Icon(Icons.repeat, color: textColor),
              title: const Text("Regular Cycle"),
              value: isRegularCycle,
              onChanged: (v) => setState(() => isRegularCycle = v),
            ),
            _tile(Icons.local_hospital_outlined, "PCOS / PCOD Status",
                subtitle:
                isPCOSDiagnosed ? "Diagnosed" : "Not diagnosed"),
            _tile(Icons.swap_horiz, "Units",
                subtitle: "Weight: $weightUnit, Height: $heightUnit"),

            // Privacy
            _sectionHeader(Icons.privacy_tip, "Privacy & Data"),
            _tile(Icons.policy_outlined, "Privacy Policy"),
            _tile(Icons.description_outlined, "Terms & Conditions"),
            _dangerTile(Icons.delete_forever_outlined, "Clear Health Data"),
            _dangerTile(Icons.person_off, "Delete Account"),

            // Support
            _sectionHeader(Icons.help_outline, "Support & Info"),
            _tile(Icons.live_help_outlined, "Help & FAQ"),
            _tile(Icons.mail_outline, "Contact Support"),
            _tile(Icons.info_outline, "About Bloom",
                subtitle: "v1.0.0 • Bloom App"),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _sectionHeader(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: primaryColor),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, {String? subtitle}) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing:
      const Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
      onTap: () {},
    );
  }

  Widget _dangerTile(IconData icon, String title) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.redAccent),
      title: const Text(
        "Logout",
        style: TextStyle(color: Colors.redAccent),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text("Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: [
              TextButton(
              onPressed: () {
        Navigator.pop(context);
        },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
        onPressed: () {
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
        builder: (_) => const BloomLoginPage(),
        ),
        (route) => false,
        );
        },
        child: const Text("Logout"),
        ),
            ],
          ),
        );
      },

    );
  }

  Widget _switchTile(
      String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      activeColor: primaryColor,
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
