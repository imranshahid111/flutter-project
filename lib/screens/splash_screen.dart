import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizes logic from RN: width * 0.55 etc.
    final size = MediaQuery.of(context).size;
    final shortest = size.shortestSide;
    final logoWidth = (shortest * 0.55).clamp(0.0, 320.0);
    final companyLogoWidth = (size.width * 0.5).clamp(0.0, 260.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/rubaika_logo.png',
                  width: logoWidth,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF777777),
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    'assets/spargus_logo.jpeg',
                    width: companyLogoWidth,
                    fit: BoxFit.contain,
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
