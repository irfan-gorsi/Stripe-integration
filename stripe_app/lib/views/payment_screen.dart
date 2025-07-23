import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../viewmodels/payment_viewmodel.dart';

class PaymentScreen extends ConsumerWidget {
  final Product product;
  const PaymentScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentVM = ref.read(paymentViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Pay")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Buying: ${product.name}"),
            Text("Amount: \$${(product.price / 100).toStringAsFixed(2)}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await paymentVM.pay(product.price);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Payment Successful")));
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")));
                }
              },
              child: Text("Pay Now"),
            )
          ],
        ),
      ),
    );
  }
}
