import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/exception.dart';

abstract class AuthenticationLocalSource {
  const AuthenticationLocalSource();

  Future<bool> cacheOnBoarding();

  Future<bool> getOnBoardingStatus();

  Future<bool> cacheToken({required String token});

  Future<String> getToken();
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
      return sharedPreferences.getBool(AppConstants.cachedKey.onBoardingKey) ??
          false;
    } catch (_) {
      throw DatabaseException(AppConstants.errorMessage.failedGetOnBoarding);
    }
  }

  @override
  Future<bool> cacheToken({required String token}) async {
    return await sharedPreferences.setString(
      AppConstants.cachedKey.tokenKey,
      token,
    );
  }

  @override
  Future<String> getToken() async {
    try {
      return sharedPreferences.getString(AppConstants.cachedKey.tokenKey) ?? "";
    } catch (_) {
      throw DatabaseException(AppConstants.errorMessage.failedGetToken);
    }
  }
}
