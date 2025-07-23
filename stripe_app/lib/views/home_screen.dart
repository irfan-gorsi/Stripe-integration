import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/product_viewmodel.dart';
import 'payment_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: products.when(
        data: (list) => ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(list[i].name),
            subtitle: Text("\$${(list[i].price / 100).toStringAsFixed(2)}"),
            trailing: ElevatedButton(
              child: Text("Buy"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => PaymentScreen(product: list[i]),
                ));
              },
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
