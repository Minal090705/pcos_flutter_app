import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloom_login_page.dart';

class BloomSplashScreen extends StatefulWidget {
  const BloomSplashScreen({super.key});

  @override
  State<BloomSplashScreen> createState() => _BloomSplashScreenState();
}

class _BloomSplashScreenState extends State<BloomSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🎬 Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 🔍 Logo scale animation
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // 🌫️ Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // ⏳ Navigate after delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const BloomLoginPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDF9),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🌸 Animated Logo
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Image.asset(
                      'assets/bloom_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🌸 App Name
              Text(
                'Bloom',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6A1B9A),
                ),
              ),

              const SizedBox(height: 10),

              // 🌸 Tagline
              Text(
                'Grow through every cycle',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 60),

              // 🌸 Loader
              const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor:
                AlwaysStoppedAnimation<Color>(Color(0xFFBA68C8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
