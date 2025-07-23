import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
final paymentViewModelProvider = Provider((ref) => PaymentViewModel());

class PaymentViewModel {
  Future<void> pay(int amount) async {
    try {
      final clientSecret = await ApiService.createPaymentIntent(amount);
      print('✅ Received clientSecret: $clientSecret');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Simple Store',
        ),
      );
      print('✅ Payment sheet initialized');

      await Stripe.instance.presentPaymentSheet();
      print('🎉 Payment completed successfully!');
    } catch (e, stackTrace) {
      print('❌ Payment exception: $e');
      print('🔍 Stack trace:\n$stackTrace');

      throw Exception("Payment failed: $e");
    }
  }
}
