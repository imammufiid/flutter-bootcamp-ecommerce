import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repository/authentication_repository.dart';

class GetOnboardingStatusUseCase extends UseCase<bool, NoParams> {
  final AuthenticationRepository authenticationRepository;

  const GetOnboardingStatusUseCase({required this.authenticationRepository});

  @override
  Future<Either<FailureResponse, bool>> call(NoParams params) =>
      authenticationRepository.getOnBoardingStatus();
}
