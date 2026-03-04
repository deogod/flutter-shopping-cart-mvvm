import '../../../../achitecture.dart';

abstract class CheckoutDataSource {
  Future<void> doCheckout(CheckoutEntity checkout);
}
