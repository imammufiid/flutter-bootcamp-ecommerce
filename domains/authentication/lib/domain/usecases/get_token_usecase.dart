import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repository/authentication_repository.dart';

class GetTokenUseCase extends UseCase<String, NoParams> {
  final AuthenticationRepository authenticationRepository;

  GetTokenUseCase({required this.authenticationRepository});

  @override
  Future<Either<FailureResponse, String>> call(NoParams params) =>
      authenticationRepository.getToken();
}
