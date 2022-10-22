import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/argument/payment/payment_va_argument.dart';
import 'package:common/utils/navigation/router/payment_router.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/divider/custom_divider.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resources/colors.gen.dart';
import 'package:common/utils/navigation/argument/arguments.dart';

class PaymentVAScreen extends StatelessWidget {
  final PaymentVAArgument argument;
  final _paymentRouter = sl<PaymentRouter>();

  PaymentVAScreen({Key? key, required this.argument}) : super(key: key);

  void _copyVA() {
    Clipboard.setData(ClipboardData(text: argument.virtualAccount));
    CustomToast.showSuccessToast(
        errorMessage: "${argument.virtualAccount} berhasil di salin");
  }

  void _navigateToHome() {
    _paymentRouter.navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        title: Text(
          "Selesaikan Pembayaran",
          style: TextStyle(
            color: ColorName.orange,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: ColorName.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorName.orange),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    argument.bankName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                Container(
                  width: 60.w,
                  height: 40.h,
                  color: ColorName.orange,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const CustomDivider(),
            const SizedBox(height: 12),
            Text(
              "Nomor Virtual Account",
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    argument.virtualAccount,
                    style: TextStyle(
                      color: ColorName.orange,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _copyVA(),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "salin",
                      style: TextStyle(
                        color: ColorName.orange,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomDivider(),
            const SizedBox(height: 20),
            Text(
              "Total Pembayaran",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8.sp),
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                Text(
                  "Total Harga",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 8.sp),
                ),
                const Spacer(),
                Text(
                  argument.totalPrices.toIDR(),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 8.sp),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                buttonColor: ColorName.orange,
                buttonText: "Selesaikan Pembayaran",
                onTap: () => _navigateToHome(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
