import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/introduction_screen/introduction_screen.dart';
import 'package:onboarding/presentation/bloc/on_boarding_bloc/on_boarding_cubit.dart';
import 'package:onboarding/presentation/bloc/on_boarding_bloc/on_boarding_state.dart';
import 'package:resources/colors.gen.dart';
import 'package:resources/assets.gen.dart';
import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:dependencies/get_it/get_it.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final AuthRouter authRouter = sl();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        final status = state.onBoardingState.status;
        if (status.isHasData) {
          authRouter.navigateToSignIn();
        }
      },
      child: IntroductionScreen(
        globalBackgroundColor: ColorName.whiteBackground,
        pages: [
          PageViewModel(
            image: Assets.images.onboarding.onBoarding1.svg(
              width: 205.w,
              height: 205.h,
            ),
            title: "Jelajahi",
            body: "Cari, temukan, dan beli produk favoritmu",
            decoration: PageDecoration(
              imageFlex: 2,
              titlePadding: const EdgeInsets.only(bottom: 10, top: 64),
              contentMargin: const EdgeInsets.symmetric(horizontal: 64),
              titleTextStyle: TextStyle(
                  color: ColorName.orange,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
              bodyTextStyle: TextStyle(
                  color: ColorName.textGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          PageViewModel(
            image: Assets.images.onboarding.onBoarding2.svg(
              width: 205.w,
              height: 205.h,
            ),
            title: "Pembayaran Mudah",
            body: "Gunakan pembayaran sesuai dengan pilihanmu",
            decoration: PageDecoration(
              imageFlex: 2,
              titlePadding: const EdgeInsets.only(bottom: 10, top: 64),
              contentMargin: const EdgeInsets.symmetric(horizontal: 64),
              titleTextStyle: TextStyle(
                  color: ColorName.orange,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
              bodyTextStyle: TextStyle(
                  color: ColorName.textGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          PageViewModel(
            image: Assets.images.onboarding.onBoarding3.svg(
              width: 205.w,
              height: 205.h,
            ),
            title: "Pengalaman Belanja",
            body: "Nikmati kenyaman berbelanja saat menjelajahi toko faviritmu",
            decoration: PageDecoration(
              imageFlex: 2,
              titlePadding: const EdgeInsets.only(bottom: 10, top: 64),
              contentMargin: const EdgeInsets.symmetric(horizontal: 64),
              titleTextStyle: TextStyle(
                  color: ColorName.orange,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500),
              bodyTextStyle: TextStyle(
                  color: ColorName.textGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
        onDone: () => context.read<OnBoardingCubit>().saveOnBoardingStatus(),
        showNextButton: false,
        showBackButton: false,
        showSkipButton: true,
        dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: ColorName.textGrey,
            activeColor: ColorName.orange,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            )),
        skip: Text(
          "Lewati",
          style: TextStyle(
              color: ColorName.orange,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        done: Text(
          "Selesai",
          style: TextStyle(
              color: ColorName.orange,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
