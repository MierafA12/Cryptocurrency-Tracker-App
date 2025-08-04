import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/crypto_model.dart';
import 'detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Crypto> wishlist = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList('wishlist') ?? [];

    setState(() {
      wishlist = storedList
          .map((item) => Crypto.fromJson(json.decode(item)))
          .toList();
    });
  }

  Future<void> removeFromWishlist(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wishlist.removeWhere((crypto) => crypto.id == id);
    List<String> updatedList =
        wishlist.map((crypto) => json.encode(crypto.toJson())).toList();
    await prefs.setStringList('wishlist', updatedList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Wishlist"),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.redAccent,
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "No items in your wishlist",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final crypto = wishlist[index];
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(crypto.imageUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(
                      crypto.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      crypto.symbol.toUpperCase(),
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeFromWishlist(crypto.id),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(crypto: crypto),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
