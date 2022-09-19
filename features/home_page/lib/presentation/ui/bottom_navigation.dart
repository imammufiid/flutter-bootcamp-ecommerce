import 'package:account/presentation/ui/screen/account_screen.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home_page/presentation/bloc/bottom_navigation_bloc/bottom_navigation_cubit.dart';
import 'package:home_page/presentation/bloc/bottom_navigation_bloc/bottom_navigation_state.dart';
import 'package:home_page/presentation/ui/home_screen.dart';
import 'package:resources/assets.gen.dart';
import 'package:resources/colors.gen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<BottomNavigationCubit>();

    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorName.white,
          body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: IndexedStack(
              index: homeCubit.state.homeState.data,
              children: [
                const HomeScreen(),
                Container(
                  color: Colors.blue,
                ),
                AccountScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
            ]),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: (value) => homeCubit.changeTab(tabIndex: value),
              currentIndex: homeCubit.state.homeState.data ?? 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorName.orange,
              unselectedItemColor: ColorName.iconGrey,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: ColorName.orange,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: ColorName.iconGrey,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Assets.images.icon.home.svg(
                    color: (homeCubit.state.homeState.data == 0)
                        ? ColorName.orange
                        : ColorName.iconGrey,
                  ),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Assets.images.icon.history.svg(
                    color: (homeCubit.state.homeState.data == 1)
                        ? ColorName.orange
                        : ColorName.iconGrey,
                  ),
                  label: "Riwayat",
                ),
                BottomNavigationBarItem(
                  icon: Assets.images.icon.account.svg(
                    color: (homeCubit.state.homeState.data == 2)
                        ? ColorName.orange
                        : ColorName.iconGrey,
                  ),
                  label: "Akun",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
