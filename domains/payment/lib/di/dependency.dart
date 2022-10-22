import 'package:dependencies/get_it/get_it.dart';
import 'package:payment/data/mapper/payment_mapper.dart';
import 'package:payment/data/repository/payment_repository_impl.dart';
import 'package:payment/data/source/remote/payment_remote_source.dart';
import 'package:payment/domain/repository/payment_repository.dart';
import 'package:payment/domain/usecase/create_transaction_usecase.dart';
import 'package:payment/domain/usecase/get_all_payment_method_usecase.dart';
import 'package:payment/domain/usecase/get_history_usercase.dart';

class PaymentDependency {
  PaymentDependency() {
    _registerDataSources();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSources() {
    sl.registerLazySingleton<PaymentRemoteSource>(
      () => PaymentRemoteSourceImpl(
        dio: sl(),
      ),
    );
  }

  void _registerMapper() => sl.registerLazySingleton<PaymentMapper>(
        () => PaymentMapper(),
      );

  void _registerRepository() => sl.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(
          remoteSource: sl(),
          mapper: sl(),
        ),
      );

  void _registerUseCases() {
    sl.registerLazySingleton<GetAllPaymentMethodUseCase>(
      () => GetAllPaymentMethodUseCase(
        repository: sl(),
      ),
    );

    sl.registerLazySingleton<CreateTransactionUseCase>(
      () => CreateTransactionUseCase(
        repository: sl(),
      ),
    );

    sl.registerLazySingleton<GetHistoryUseCase>(
      () => GetHistoryUseCase(repository: sl()),
    );
  }
}
