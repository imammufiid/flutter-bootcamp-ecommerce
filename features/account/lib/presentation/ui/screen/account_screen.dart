import 'package:account/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/ui/widget/username_avatar.dart';
import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:common/utils/navigation/router/home_router.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/button/chevron_button.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';
import 'package:account/presentation/bloc/logout_bloc/logout_state.dart';
import 'package:component/widget/stack/loading_stack.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final HomeRouter homeRouter = sl();
  final AuthRouter authRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.textFieldBackgroundGrey,
      appBar: AppBar(
        backgroundColor: ColorName.white,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          "Akun Saya",
          style: TextStyle(
            color: ColorName.orange,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          final status = state.logoutState.status;
          if (status.isHasData) {
            authRouter.navigateToSignIn();
          }
        },
        builder: (context, state) {
          final status = state.logoutState.status;
          return LoadingStack(
            isLoading: status.isLoading,
            widget: Container(
              color: ColorName.white,
              child: ListView(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                shrinkWrap: true,
                children: [
                  const UsernameAvatar(),
                  SizedBox(height: 30.h),
                  ChevronButton(
                    buttonText: "Data Diri",
                    onTap: () async {
                      await homeRouter.navigateToEditProfile()?.then((value) {
                        if (value == "update") {
                          context.read<UserCubit>().getUser();
                        }
                      });
                    },
                  ),
                  ChevronButton(
                    buttonText: "Logout",
                    onTap: () => context.read<LogoutCubit>().logout(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
