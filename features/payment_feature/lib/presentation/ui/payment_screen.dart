import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/navigation/argument/payment/payment_argument.dart';
import 'package:common/utils/navigation/argument/payment/payment_method_argument.dart';
import 'package:common/utils/navigation/argument/payment/payment_va_argument.dart';
import 'package:common/utils/navigation/router/payment_router.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/button/payment_transaction_button.dart';
import 'package:component/widget/divider/custom_divider.dart';
import 'package:component/widget/loading/dialog_loading.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:payment/domain/entity/response/create_payment_entity.dart';
import 'package:payment_feature/presentation/bloc/bloc.dart';
import 'package:resources/colors.gen.dart';
import 'package:component/widget/button/payment_button.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentArgument argument;

  const PaymentScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _paymentRouter = sl<PaymentRouter>();

  void _navigateToPaymentMethod() async {
    final result = await _paymentRouter.navigateToPaymentMethod();
    // getting result data from list payment method screen
    if (result != null) {
      if (result is PaymentMethodArgument) {
        _selectPaymentMethod(result);
      }
    }
  }

  void _selectPaymentMethod(PaymentMethodArgument argument) {
    context.read<PaymentCubit>().selectPaymentMethod(argument);
  }

  void _navigateToVA(PaymentVAArgument argument) {
    _paymentRouter.navigateToPaymentVA(argument);
  }

  void _paymentProduct(String paymentCode) {
    context.read<PaymentCubit>().createTransaction(paymentCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        final createPaymentState = state.createPaymentState.status;
        if (createPaymentState.isError) {
          DialogLoading.dismiss(context);
          CustomToast.showErrorToast(
              errorMessage: state.createPaymentState.message);
        } else if (createPaymentState.isLoading) {
          DialogLoading.show(context);
        } else if (createPaymentState.isHasData) {
          DialogLoading.dismiss(context);
          final bankName = state.selectedPaymentMethod?.bankName ?? "";
          final createPaymentData =
              state.createPaymentState.data ?? const CreatePaymentDataEntity();
          _navigateToVA(PaymentVAArgument(
            bankName: bankName,
            virtualAccount: createPaymentData.externalData.data,
            totalPrices: widget.argument.totalAmount,
          ));
        }
      },
      child: Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          title: Text(
            "Pembayaran",
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Metode Pembayaran",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => _navigateToPaymentMethod(),
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: ColorName.orange),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const CustomDivider(),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 14),
                        width: 60.w,
                        height: 40.h,
                        color: ColorName.orange,
                      ),
                      BlocBuilder<PaymentCubit, PaymentState>(
                          builder: (context, state) {
                        final data = state.selectedPaymentMethod;
                        final bankName =
                            (data == null) ? "Pilih Pembayaran" : data.bankName;
                        return Text(
                          bankName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
            CustomDivider(height: 10.h),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ringkasan Belanja",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "Total Harga ${widget.argument.totalProduct} barang",
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.argument.totalAmount.toIDR(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
              final data = state.selectedPaymentMethod;
              final textButton = (data == null) ? "Pilih Pembayaran" : "Bayar";
              return PaymentTransactionButton(
                total: widget.argument.totalAmount,
                textButton: textButton,
                paymentTap: (data == null)
                    ? null
                    : () => _paymentProduct(data.paymentCode),
              );
            })
          ],
        ),
      ),
    );
  }
}
