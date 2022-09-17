import 'package:auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:auth/presentation/ui/sign_up_screen.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:home_page/presentation/bloc/banner_bloc/banner_cubit.dart';
import 'package:home_page/presentation/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import 'package:home_page/presentation/bloc/product_category_bloc/product_category_bloc.dart';
import 'package:home_page/presentation/bloc/product_cubit/product_cubit.dart';
import 'package:home_page/presentation/ui/bottom_navigation.dart';
import 'package:onboarding/presentation/bloc/on_boarding_bloc/on_boarding_cubit.dart';
import 'package:onboarding/presentation/bloc/splash_bloc/splash_cubit.dart';
import 'package:onboarding/presentation/ui/on_boarding_screen.dart';
import 'package:onboarding/presentation/ui/splash_screen.dart';
import 'package:auth/presentation/ui/sign_in_screen.dart';
import 'injections/injections.dart';
import 'package:dependencies/get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(
        title: 'Flutter E Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (_) => SplashCubit(
            getOnboardingStatusUseCase: sl(),
            getTokenUseCase: sl(),
          )..initSplash(),
          child: SplashScreen(),
        ),
        navigatorKey: NavigationHelperImpl.navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case AppRoutes.onboarding:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                    create: (_) =>
                        OnBoardingCubit(cacheOnboardingUseCase: sl()),
                    child: OnBoardingScreen()),
              );
            case AppRoutes.signIn:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => SignInBloc(
                    signInUseCase: sl(),
                    cacheTokenUseCase: sl(),
                  ),
                  child: SignInScreen(),
                ),
              );
            case AppRoutes.signUp:
              return MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => SignUpBloc(
                          signUpUseCase: sl(),
                          cacheTokenUseCase: sl(),
                        ),
                        child: SignUpScreen(),
                      ));
            case AppRoutes.home:
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => BottomNavigationCubit()),
                    BlocProvider(
                      create: (_) =>
                          BannerCubit(bannerUseCase: sl())..getBanners(),
                    ),
                    BlocProvider(
                      create: (_) =>
                          ProductCubit(productUseCase: sl())..getProducts(),
                    ),
                    BlocProvider(
                      create: (_) =>
                          ProductCategoryCubit(productCategoryUseCase: sl())
                            ..getProductCategories(),
                    ),
                  ],
                  child: const BottomNavigation(),
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => SplashScreen());
          }
        },
      ),
    );
  }
}
