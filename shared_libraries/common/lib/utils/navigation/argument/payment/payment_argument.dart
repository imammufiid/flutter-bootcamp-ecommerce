import 'package:dependencies/equatable/equatable.dart';

class PaymentArgument extends Equatable {
  final int totalAmount;
  final int totalProduct;

  const PaymentArgument(
      {required this.totalAmount, required this.totalProduct});

  @override
  List<Object?> get props => [totalAmount, totalProduct];
}
