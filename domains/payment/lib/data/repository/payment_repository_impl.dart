import 'package:common/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:payment/data/mapper/payment_mapper.dart';
import 'package:payment/data/source/remote/payment_remote_source.dart';
import 'package:payment/domain/entity/response/create_payment_entity.dart';
import 'package:payment/domain/entity/response/payment_entity.dart';
import 'package:payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteSource remoteSource;
  final PaymentMapper mapper;

  PaymentRepositoryImpl({required this.remoteSource, required this.mapper});

  @override
  Future<Either<FailureResponse, CreatePaymentDataEntity>> createTransaction(
      String paymentCode) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureResponse, List<PaymentDataEntity>>>
      getAllPaymentMethod() {
    // TODO: implement getAllPaymentMethod
    throw UnimplementedError();
  }
}
