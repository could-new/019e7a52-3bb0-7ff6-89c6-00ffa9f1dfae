import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart' hide TextDirection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase (User must connect their project later)
  // await Supabase.initialize(url: 'YOUR_SUPABASE_URL', anonKey: 'YOUR_ANON_KEY');

  runApp(const MultiVendorApp());
}

class MultiVendorApp extends StatelessWidget {
  const MultiVendorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'منصة التجارة الإلكترونية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto', // Change to an Arabic font later if desired
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // Force RTL for Arabic
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/merchant/dashboard': (context) => const MerchantDashboard(),
        '/brand': (context) => const BrandScreen(), // Needs arguments normally, but defined here for safety
      },
    );
  }
}

// Temporary placeholders for routes
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('منصة التجارة الإلكترونية - الواجهة الرئيسية'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/merchant/dashboard'),
              child: const Text('لوحة تحكم التاجر'),
            ),
          ],
        ),
      ),
    );
  }
}

class MerchantDashboard extends StatelessWidget {
  const MerchantDashboard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم التاجر')),
      body: const Center(child: Text('لوحة التحكم قيد الإنشاء')),
    );
  }
}

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صفحة العلامة التجارية')),
      body: const Center(child: Text('منتجات التاجر')),
    );
  }
}
