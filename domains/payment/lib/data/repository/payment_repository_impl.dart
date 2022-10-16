import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
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
      String paymentCode) async {
    try {
      final response = await remoteSource.createTransaction(paymentCode);
      final transactions =
          mapper.mapListCreateTransactionDataDtoToEntity(response.data);
      bool success = false;
      String errorMessage = "";
      CreatePaymentDataEntity data = const CreatePaymentDataEntity();
      for (var i in transactions) {
        final createPayment = await remoteSource.createPayment(i.transactionId);
        if (createPayment.status ?? 0 == 200) {
          success = true;
          final result =
              mapper.mapCreatePaymentDataDtoToEntity(createPayment.data);
          data = result;
        } else {
          success = false;
          data = const CreatePaymentDataEntity();
          errorMessage = createPayment.message ?? "";
          break;
        }
      }

      if (success) {
        return Right(data);
      } else {
        return Left(FailureResponse(errorMessage: errorMessage));
      }
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<PaymentDataEntity>>>
      getAllPaymentMethod() async {
    try {
      final response = await remoteSource.getAllPaymentMethod();
      return Right(mapper.mapListPaymentDataDtoToEntity(response.data));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }
}
