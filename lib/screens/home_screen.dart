import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';
import '../widgets/crypto_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CryptoProvider>(context, listen: false).loadCrypto();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoProvider = Provider.of<CryptoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Crypto Tracker",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: cryptoProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.red))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cryptoProvider.cryptoList.length,
              itemBuilder: (context, index) {
                final crypto = cryptoProvider.cryptoList[index];
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        crypto.symbol[0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      crypto.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      crypto.symbol.toUpperCase(),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    trailing: Text(
                      '\$${crypto.currentPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
