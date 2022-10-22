import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/card/history_card.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:payment_feature/presentation/bloc/history/bloc.dart';
import 'package:resources/colors.gen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    context.read<HistoryCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        title: Text(
          "Riwayat Belanja",
          style: TextStyle(
            color: ColorName.orange,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: ColorName.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: ColorName.orange),
      ),
      body: Center(
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state.historyState.status.isLoading) {
              return const Center(child: CustomCircularProgressIndicator());
            } else if (state.historyState.status.isError) {
              return Center(child: Text(state.historyState.message));
            } else if (state.historyState.status.isNoData) {
              return Center(child: Text(state.historyState.message));
            } else if (state.historyState.status.isHasData) {
              final histories = state.historyState.data?.data ?? [];
              return ListView.builder(
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  final history = histories[index];
                  return HistoryCard(
                    statusPayment: history.paymentTransaction.statusPayment,
                    createdAt: history.createdAt,
                    productUrl: history.productData.first.product.imageUrl,
                    productName: history.productData.first.product.name,
                    totalProduct: history.productData.first.quantity,
                    productPrice: history.amount,
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
