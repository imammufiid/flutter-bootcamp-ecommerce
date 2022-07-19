import 'package:dependencies/dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:payment/domain/entity/response/create_payment_entity.dart';
import 'package:payment/domain/entity/response/payment_entity.dart';

abstract class PaymentRepository {
  const PaymentRepository();

  Future<Either<FailureResponse, List<PaymentDataEntity>>>
      getAllPaymentMethod();

  Future<Either<FailureResponse, CreatePaymentDataEntity>> createTransaction(String paymentCode);
}
