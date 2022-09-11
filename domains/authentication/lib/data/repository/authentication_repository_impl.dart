import 'package:authentication/data/source/authentication_local_source.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalSource authenticationLocalSource;

  AuthenticationRepositoryImpl({required this.authenticationLocalSource});

  @override
  Future<Either<FailureResponse, bool>> cacheOnBoarding() async {
    try {
      await authenticationLocalSource.cacheOnBoarding();
      return const Right(true);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, bool>> getOnBoardingStatus() async {
    try {
      final response = await authenticationLocalSource.getOnBoardingStatus();
      return Right(response);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }
}
