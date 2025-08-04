class Crypto {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String imageUrl;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.imageUrl,
  });
  
   Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'currentPrice': currentPrice,
        'imageUrl': imageUrl,
      };

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: json['current_price'].toDouble(),
      imageUrl: json['image'],
    );
  }
}
