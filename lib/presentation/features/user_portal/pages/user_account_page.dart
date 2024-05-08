import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/infrastructure/models/general/cubitStatus.dart';
import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:smart_assistant_app/presentation/common/cubit/auth/auth_cubit.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/appbars/auc_pop_sliver_appbar.dart';
import 'package:smart_assistant_app/presentation/common/widgets/overlays/auc_loading_overlay.dart';
import 'package:smart_assistant_app/presentation/features/user_portal/cubit/profile/cubit/user_profile_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool allParticipationsSelected = true;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    tabController.addListener(_tabListener);
  }

  void _tabListener() {
    allParticipationsSelected = tabController.index == 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserProfileCubit, UserProfileState, bool>(
      selector: (state) {
        return state.mainStatus == MainStatus.loading;
      },
      builder: (context, isFetchingProfile) {
        return MainLoadingOverlay(
          active: isFetchingProfile,
          child: Scaffold(
            body: MultiBlocListener(
              listeners: [
                BlocListener<UserProfileCubit, UserProfileState>(
                  listener: (context, state) {
                    if (state.status?.action == CubitAction.profileSwitch) {
                      if (state.mainStatus == MainStatus.loaded) {
                        /// fetch new profile related

                        BottomSheetHelper.showStatusSheet(
                          text: context.t.messages.profile_switched,
                          statusType: SheetStatusType.success,
                          context: context,
                        );
                      } else if (state.mainStatus == MainStatus.failure) {
                        context.read<AuthCubit>().logOut();
                      }
                    }
                  },
                ),
              ],
              child: CustomScrollView(
                slivers: [
                  MainPopSliverAppBar(
                    title: t.profile.label,
                    backBtnBgColor: AppColors.backgroundLightPurple,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
