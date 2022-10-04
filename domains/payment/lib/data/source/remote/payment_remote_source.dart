import 'package:dependencies/dio/dio.dart';
import 'package:payment/data/model/all_payment_response_dto.dart';
import 'package:payment/data/model/create_payment_response_dto.dart';
import 'package:payment/data/model/create_transaction_response_dto.dart';

abstract class PaymentRemoteSource {
  const PaymentRemoteSource();

  Future<AllPaymentResponseDto> getAllPaymentMethod();

  Future<CreateTransactionResponseDto> createTransaction(String paymentCode);

  Future<CreatePaymentResponseDto> createPayment(String transactionId);
}

class PaymentRemoteSourceImpl implements PaymentRemoteSource {
  final Dio dio;

  PaymentRemoteSourceImpl({required this.dio});

  @override
  Future<CreatePaymentResponseDto> createPayment(String transactionId) {
    // TODO: implement createPayment
    throw UnimplementedError();
  }

  @override
  Future<CreateTransactionResponseDto> createTransaction(String paymentCode) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<AllPaymentResponseDto> getAllPaymentMethod() {
    // TODO: implement getAllPaymentMethod
    throw UnimplementedError();
  }
}
