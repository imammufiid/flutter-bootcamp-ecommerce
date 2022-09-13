import 'package:authentication/data/source/local/authentication_local_source.dart';
import 'package:authentication/data/source/remote/authentication_remote_source.dart';
import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/entity/body/auth_response_entity.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalSource authenticationLocalSource;
  final AuthenticationRemoteSource authenticationRemoteSource;
  final AuthenticationMapper mapper;

  AuthenticationRepositoryImpl({
    required this.authenticationLocalSource,
    required this.authenticationRemoteSource,
    required this.mapper,
  });

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

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> signIn(
      {required AuthRequestEntity authRequestEntity}) async {
    try {
      final response = await authenticationRemoteSource.signIn(
        authRequestDto:
            mapper.mapAuthRequestEntityToAuthRequestDTO(authRequestEntity),
      );
      return Right(mapper.mapAuthResponseDTOToAuthResponseEntity(response));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message].toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> signUp(
      {required AuthRequestEntity authRequestEntity}) async {
    try {
      final response = await authenticationRemoteSource.signUp(
        authRequestDto:
            mapper.mapAuthRequestEntityToAuthRequestDTO(authRequestEntity),
      );
      return Right(mapper.mapAuthResponseDTOToAuthResponseEntity(response));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message].toString() ??
                  error.response.toString(),
        ),
      );
    }
  }
}
