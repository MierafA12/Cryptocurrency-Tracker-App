import 'package:flutter/material.dart';
import '../models/crypto_model.dart';

class CryptoTile extends StatelessWidget {
  final Crypto crypto;
  const CryptoTile({required this.crypto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(crypto.imageUrl, width: 40),
      title: Text(crypto.name),
      subtitle: Text(crypto.symbol.toUpperCase()),
      trailing: Text('\$${crypto.currentPrice.toStringAsFixed(2)}'),
      onTap: () {
        // Navigate to detail screen
      },
    );
  }
}
