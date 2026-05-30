import 'package:flutter/material.dart';
import '../models/models.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية - المتاجر'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('مرحباً بك في منصة التجارة الإلكترونية'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/brand', arguments: Merchant(id: '1', name: 'متجر تجريبي', details: 'تفاصيل'));
              },
              child: const Text('عرض متجر تجريبي'),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final merchant = ModalRoute.of(context)!.settings.arguments as Merchant?;
    return Scaffold(
      appBar: AppBar(
        title: Text(merchant?.name ?? 'العلامة التجارية'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          final product = Product(
            id: 'p$index',
            merchantId: merchant?.id ?? '1',
            name: 'منتج $index',
            description: 'وصف المنتج $index',
            price: 15.5 + index,
          );
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text(product.merchantName),
              trailing: Text(CurrencyFormatter.formatKWD(product.price)),
              onTap: () {
                // Checkout mock
              },
            ),
          );
        },
      ),
    );
  }
}
