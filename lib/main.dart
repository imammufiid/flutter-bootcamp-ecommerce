import 'package:account/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:account/presentation/bloc/update_photo_bloc/update_photo_cubit.dart';
import 'package:account/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/ui/screen/update_profile_screen.dart';
import 'package:auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:auth/presentation/ui/sign_up_screen.dart';
import 'package:cart_feature/presentation/bloc/bloc.dart';
import 'package:cart_feature/presentation/ui/cart_list_screen.dart';
import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/navigation/argument/payment/payment_argument.dart';
import 'package:common/utils/navigation/argument/payment/payment_va_argument.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/bloc.dart';
import 'package:detail_product/presentation/ui/detail_product_screen.dart';
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
import 'package:payment_feature/presentation/bloc/history/bloc.dart';
import 'package:payment_feature/presentation/bloc/payment/bloc.dart';
import 'package:payment_feature/presentation/ui/payment/payment_method_screen.dart';
import 'package:payment_feature/presentation/ui/payment/payment_screen.dart';
import 'package:payment_feature/presentation/ui/payment/payment_va_screen.dart';
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
          final argument = settings.arguments;
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
                ),
              );
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
                    BlocProvider(
                      create: (_) => UserCubit(getUserUseCase: sl())..getUser(),
                    ),
                    BlocProvider(
                      create: (_) => LogoutCubit(logoutUseCase: sl()),
                    ),
                    BlocProvider<HistoryCubit>(
                      create: (_) =>
                          HistoryCubit(getHistoryUseCase: sl()),
                    ),
                  ],
                  child: const BottomNavigation(),
                ),
              );
            case AppRoutes.editProfile:
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => UserCubit(getUserUseCase: sl())..getUser(),
                    ),
                    BlocProvider(
                      create: (_) => UpdateProfileBloc(
                          updateUserUseCase: sl(), firebaseMessaging: sl()),
                    ),
                    BlocProvider(
                      create: (_) => UpdatePhotoCubit(
                          imagePicker: sl(), uploadPhotoUseCase: sl()),
                    )
                  ],
                  child: UpdateProfileScreen(),
                ),
              );
            case AppRoutes.detailProduct:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => ProductDetailCubit(
                    getProductDetailUseCase: sl(),
                    getSellerUseCase: sl(),
                    addToCartUseCase: sl(),
                  ),
                  child: DetailProductScreen(
                      argument: argument as DetailProductArgument),
                ),
              );
            case AppRoutes.cartList:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => CartCubit(
                    getCartsUseCase: sl(),
                    addToCartUseCase: sl(),
                    deleteCartUseCase: sl(),
                  ),
                  child: const CartListScreen(),
                ),
              );
            case AppRoutes.payment:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<PaymentCubit>(
                  create: (_) => PaymentCubit(
                    getAllPaymentMethodUseCase: sl(),
                    createTransactionUseCase: sl(),
                  ),
                  child: PaymentScreen(
                    argument: argument as PaymentArgument,
                  ),
                ),
              );
            case AppRoutes.paymentMethod:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<PaymentCubit>(
                  create: (_) => PaymentCubit(
                    getAllPaymentMethodUseCase: sl(),
                    createTransactionUseCase: sl(),
                  ),
                  child: const PaymentMethodScreen(),
                ),
              );
            case AppRoutes.paymentVa:
              return MaterialPageRoute(
                builder: (_) => PaymentVAScreen(
                  argument: argument as PaymentVAArgument,
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
