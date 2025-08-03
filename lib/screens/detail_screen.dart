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
          final price = (entry.value[1] as num).toDouble();
          return FlSpot(index, price);
        }).toList();

        setState(() {
          priceSpots = spots;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load chart data');
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
        title: Text('${widget.crypto.name} Details'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(widget.crypto.imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.crypto.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.crypto.symbol.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${widget.crypto.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '7-Day Price Chart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
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
      ),
    );
  }
}
