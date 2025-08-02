import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/crypto.webp',
              fit: BoxFit.cover,
            ),
          ),

          // 🔲 Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

          // 🔲 Overlay content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🟥 Title
                    Text(
                      'Track Cryptocurrency\nIn Real Time',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🟥 Subtitle
                    Text(
                      'Stay ahead with live market trends,\nprice updates, and coin details.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red[100],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 🟥 CTA Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text(
                          'Explore Coins',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
