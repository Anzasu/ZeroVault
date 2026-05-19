import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zero_vault/backend/providers/auth_provider.dart';
import 'package:zero_vault/frontend/flutter_flow/flutter_flow_theme.dart';
import 'package:zero_vault/frontend/pages/lock_screen/lock_screen_widget.dart';
import 'package:zero_vault/frontend/pages/lock_screen/pin_setup_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterInit();
  }

  Future<void> _navigateAfterInit() async {
    final auth = context.read<AuthProvider>();
    
    await Future.delayed(const Duration(seconds: 2));
    
    while (auth.isLoading) {
      await Future.delayed(const Duration(milliseconds: 200));
    }

    if (!mounted) return;

    // Navigate to the correct page
    if (auth.hasPin) {
      context.go(LockScreenWidget.routePath);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PinSetupPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/zerovaultLogo2.JPG',
                width: MediaQuery.sizeOf(context).width * 0.9,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 40),
            // Tagline
            Text(
              'Zero tracking. Zero cloud.\n100% privacy',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.montserrat(
                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    color: const Color(0xFFE5E7EB),
                    fontSize: 17.0,
                    letterSpacing: 0.0,
                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
            ),
            const SizedBox(height: 60),
            // Loading indicator
            const CircularProgressIndicator(
              color: Color(0xFF0077FF),
            ),
          ],
        ),
      ),
    );
  }
}