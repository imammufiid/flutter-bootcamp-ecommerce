import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/bloc/user_bloc/user_state.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

class UsernameAvatar extends StatelessWidget {
  const UsernameAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final status = state.userState.status;
        if (status.isLoading) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        } else if (status.isHasData) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: CachedNetworkImage(
                  width: 45.w,
                  height: 45.w,
                  imageUrl: state.userState.data?.imageUrl ?? "",
                  placeholder: (context, url) => const Center(
                    child: CustomCircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(width: 9.w),
              Text(
                state.userState.data!.fullName.isEmpty
                    ? state.userState.data!.username
                    : state.userState.data!.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: ColorName.textBlack,
                ),
              )
            ],
          );
        } else if (status.isError) {
          return Center(child: Text(state.userState.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
