import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';

abstract class ProductRoutes {
  void navigateToCartList();
}

class ProductRouteImpl extends ProductRoutes {
  final NavigationHelper navigationHelper;

  ProductRouteImpl({required this.navigationHelper});

  @override
  void navigateToCartList() => navigationHelper.pushNamed(AppRoutes.cartList);
}
