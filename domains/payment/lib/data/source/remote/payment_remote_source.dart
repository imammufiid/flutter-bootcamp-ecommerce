import 'package:common/utils/constants/app_constants.dart';
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
  Future<CreatePaymentResponseDto> createPayment(String transactionId) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.createPayment,
        queryParameters: {"transaction_id": transactionId},
      );
      return CreatePaymentResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateTransactionResponseDto> createTransaction(
      String paymentCode) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.createTransaction,
        queryParameters: {"payment": paymentCode},
      );
      return CreateTransactionResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllPaymentResponseDto> getAllPaymentMethod() async {
    try {
      final response = await dio.get(AppConstants.appApi.paymentMethod);
      return AllPaymentResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
