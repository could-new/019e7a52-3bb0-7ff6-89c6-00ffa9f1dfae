import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatKWD(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en',
      symbol: 'KWD',
      decimalDigits: 3,
    );
    return formatter.format(amount);
  }
}

class Merchant {
  final String id;
  final String name;
  final String details;
  final String userId;

  Merchant({
    required this.id,
    required this.name,
    required this.details,
    required this.userId,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'],
      name: json['name'],
      details: json['details'] ?? '',
      userId: json['user_id'],
    );
  }
}

class Product {
  final String id;
  final String merchantId;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.merchantId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      merchantId: json['merchant_id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
    );
  }
}

class Order {
  final String id;
  final String merchantId;
  final double totalAmount;
  final String status;

  Order({
    required this.id,
    required this.merchantId,
    required this.totalAmount,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      merchantId: json['merchant_id'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'],
    );
  }
}
