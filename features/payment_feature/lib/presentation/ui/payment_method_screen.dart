import 'package:common/utils/navigation/argument/payment/payment_method_argument.dart';
import 'package:common/utils/navigation/router/payment_router.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/divider/custom_divider.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_feature/presentation/bloc/bloc.dart';
import 'package:resources/colors.gen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _paymentRouter = sl<PaymentRouter>();

  @override
  void initState() {
    super.initState();
    _loadPaymentMethod(context);
  }

  void _loadPaymentMethod(BuildContext context) {
    context.read<PaymentCubit>().getAllPaymentMethod();
  }

  void _selectedPaymentRoute(PaymentMethodArgument argument) {
    _paymentRouter.selectPayment(argument);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.paymentMethodState.status.isLoading) {
              return const CustomCircularProgressIndicator();
            } else if (state.paymentMethodState.status.isError) {
              return Center(child: Text(state.paymentMethodState.message));
            } else if (state.paymentMethodState.status.isNoData) {
              return Center(child: Text(state.paymentMethodState.message));
            } else if (state.paymentMethodState.status.isHasData) {
              final payments = state.paymentMethodState.data ?? [];
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return GestureDetector(
                    onTap: () => _selectedPaymentRoute(PaymentMethodArgument(
                        bankName: payment.name, paymentCode: payment.code)),
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  width: 60.w,
                                  height: 40.h,
                                  color: ColorName.orange,
                                ),
                                Expanded(
                                  child: Text(
                                    payment.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                            const SizedBox(height: 10),
                            const CustomDivider(height: 2)
                          ],
                        )),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
