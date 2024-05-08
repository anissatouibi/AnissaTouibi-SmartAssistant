import 'package:smart_assistant_app/core/extensions/string_extensions.dart';
import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/cubit/auth/auth_cubit.dart';
import 'package:smart_assistant_app/presentation/common/routes/router.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:smart_assistant_app/presentation/features/user_portal/cubit/profile/cubit/user_profile_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainMainTabsSliverAppBar extends StatelessWidget {
  const MainMainTabsSliverAppBar({
    super.key,
    this.isHome = false,
    this.title = '',
    this.elevation,
  });
  final bool isHome;
  final String title;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 64.h,
      elevation: elevation,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 5),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isHome)
                Builder(builder: (context) {
                  final isAuthed = context.watch<AuthCubit>().state is Authenticated;
                  return Spacer(flex: isAuthed ? 1 : 2);
                }),
              if (isHome)
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: GestureDetector(
                              onTap: () {
                                // context.router.push(const AucWonCongratzRoute());
                                // BottomSheetHelper.showWidgetBottomSheet(
                                //     context: context,
                                //     content: const PostPaymentStatusSheetContent(
                                //       success: true,
                                //     ));
                              },
                              child: const MainHomeLogo())),
                      const UserAuthedAvatarWidget(),
                    ],
                  ),
                ),
              if (!isHome)
                Text(
                  //title.toUpperCase(),
                  title,
                  style: AppTextStyles.px19wBold(context),
                ),
              if (!isHome) // centerer
                SizedBox(
                  height: 40.h,
                  width: 40.h,
                )
            ]),
      ),
    );
  }
}

class UserAuthedAvatarWidget extends StatelessWidget {
  const UserAuthedAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        return BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, profileState) {
            if (profileState.mainStatus == MainStatus.loaded) {
              final profile = profileState.currentProfile!;

              return Row(
                children: [
                  SizedBox(width: 10.w),
                  ClipOval(
                    child: Container(
                      height: 45.h,
                      width: 45.h,
                      color: AppColors.ramliColor,
                      child: Center(
                        child: Text(
                          profile.name.firstLetterCap,
                          style: AppTextStyles.px28wBold(context)
                              .toRamliColor
                              .toEnglishFont
                              .copyWith(fontSize: 28.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class MainHomeLogo extends StatelessWidget {
  const MainHomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.5),
      child: MainSvgImage(
        path: "MainAssetConstantsSvgs.aucMazadWQatarCustomsLogos2",
        darkPath: "MainAssetConstantsSvgs.aucMazadWQatarCustomsLogos2",
        height: 45.h,
        width: 210.w,
      ),
    );
  }
}
