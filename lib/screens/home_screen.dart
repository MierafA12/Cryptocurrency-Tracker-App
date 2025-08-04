import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';
import '../screens/detail_screen.dart';
import '../screens/wishlist_screen.dart'; // ✅ Import your Wishlist screen

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<CryptoProvider>(context, listen: false).loadCrypto();
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WishlistScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
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
        foregroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? (cryptoProvider.isLoading
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(crypto: crypto),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(crypto.imageUrl),
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
                ))
          : SizedBox.shrink(), // Empty if not on Home
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
