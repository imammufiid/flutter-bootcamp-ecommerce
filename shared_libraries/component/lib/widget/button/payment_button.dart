import 'package:flutter/material.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:resources/colors.gen.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:component/widget/divider/divider.dart';

class PaymentButton extends StatelessWidget {
  final VoidCallback onPressedBuy;
  final VoidCallback onPressedCart;

  const PaymentButton({
    Key? key,
    required this.onPressedBuy,
    required this.onPressedCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: ColorName.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDivider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonText: "Beli Langsung",
                      buttonColor: ColorName.lightOrange,
                      onTap: onPressedBuy,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: CustomButton(
                      buttonText: "Keranjang",
                      buttonColor: ColorName.orange,
                      onTap: onPressedCart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
