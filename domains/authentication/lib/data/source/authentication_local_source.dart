import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/exception.dart';

abstract class AuthenticationLocalSource {
  const AuthenticationLocalSource();

  Future<bool> cacheOnBoarding();

  Future<bool> getOnBoardingStatus();
}

class AuthenticationLocalSourceImpl implements AuthenticationLocalSource {
  final SharedPreferences sharedPreferences;

  const AuthenticationLocalSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheOnBoarding() async {
    return await sharedPreferences.setBool(
      AppConstants.cachedKey.onBoardingKey,
      true,
    );
  }

  @override
  Future<bool> getOnBoardingStatus() async {
    try {
      return sharedPreferences.getBool(AppConstants.cachedKey.onBoardingKey) ?? false;
    } catch (_) {
      throw DatabaseException(AppConstants.errorMessage.failedGetOnBoarding);
    }
  }
}
