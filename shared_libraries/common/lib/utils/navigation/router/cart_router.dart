import 'package:common/utils/navigation/argument/payment/payment_argument.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';

abstract class CartRouter {
  void navigateToPayment(int totalAmount, int totalProduct);
}

class CartRouterImpl implements CartRouter {
  final NavigationHelper navigationHelper;

  CartRouterImpl({
    required this.navigationHelper,
  });

  @override
  void navigateToPayment(int totalAmount, int totalProduct) =>
      navigationHelper.pushNamed(
        AppRoutes.payment,
        arguments: PaymentArgument(
          totalAmount: totalAmount,
          totalProduct: totalProduct,
        ),
      );
}
