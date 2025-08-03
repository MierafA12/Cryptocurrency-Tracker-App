// lib/screens/detail_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import '../models/crypto_model.dart';

class DetailScreen extends StatefulWidget {
  final Crypto crypto;

  const DetailScreen({super.key, required this.crypto});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<FlSpot> priceSpots = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistoricalPrices();
  }

  Future<void> fetchHistoricalPrices() async {
    try {
      final url =
          'https://api.coingecko.com/api/v3/coins/${widget.crypto.id}/market_chart?vs_currency=usd&days=7';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> prices = data['prices'];

        final List<FlSpot> spots = prices.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final price = (entry.value[1] as num).toDouble(); // y = price
          return FlSpot(index, price);
        }).toList();

        setState(() {
          priceSpots = spots;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('${widget.crypto.name} Details',
            style: TextStyle(color: Colors.redAccent)),
        backgroundColor: Colors.grey[900],
        iconTheme: IconThemeData(color: Colors.redAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.crypto.imageUrl),
            ),
            SizedBox(height: 20),
            Text(
              widget.crypto.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.crypto.symbol.toUpperCase(),
              style: TextStyle(color: Colors.redAccent, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '\$${widget.crypto.currentPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.greenAccent, fontSize: 22),
            ),
            SizedBox(height: 40),
            isLoading
                ? CircularProgressIndicator(color: Colors.redAccent)
                : Column(
                    children: [
                      Text(
                        '7-Day Price Chart',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(show: false),
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: priceSpots,
                                isCurved: true,
                                color: Colors.redAccent,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.redAccent.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
