import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/crypto_provider.dart';
import './screens/onbording_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CryptoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnbordingScreen(),
      ),
    ),
  );
}
