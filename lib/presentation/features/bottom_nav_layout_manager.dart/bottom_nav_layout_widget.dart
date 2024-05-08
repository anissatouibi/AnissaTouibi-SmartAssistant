import 'dart:io';

import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/injection.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/cubit/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/features/bottom_nav_layout_manager.dart/models/tabItem.dart';

import 'package:smart_assistant_app/presentation/features/bottom_nav_layout_manager.dart/widgets/CustomRowBottomNavBar.dart/fts_floating_bottom_nav_bar.dart';
import 'package:smart_assistant_app/presentation/features/static/pages/common_widget_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/BottomNavLayoutResources/layout.dart';
import 'widgets/BottomNavLayoutResources/page_stack.dart';

class BottomNavLayoutWidget extends StatelessWidget {
  const BottomNavLayoutWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final myPageStack = getIt<ReorderToFrontPageStack>();

    return Container(
      color: Platform.isIOS ? Colors.white : Colors.black,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 0),
        child: WillPopScope(
          onWillPop: () {
            if (myPageStack.stack.length == 1) {
              if (myPageStack.peek() != 0) {
                myPageStack.push(0);
                return Future.value(true);
              }
            }

            if (myPageStack.peek() == 0) {
              myPageStack.stack.clear();
              return Future.value(false);
            }
            // updating the drawer item selection is in the btmNavLayout logic itself
            return Future.value(true);
          },
          child: BottomNavLayoutContent(myPageStack: myPageStack),
        ),
      ),
    );
  }
}

class BottomNavLayoutContent extends StatefulWidget {
  const BottomNavLayoutContent({super.key, required this.myPageStack});
  final ReorderToFrontPageStack myPageStack;

  @override
  State<BottomNavLayoutContent> createState() => _BottomNavLayoutContentState();
}

class _BottomNavLayoutContentState extends State<BottomNavLayoutContent> {
  late BottomNavbarCubit btmNavBarCubit;
  @override
  void initState() {
    super.initState();
    btmNavBarCubit = context.read<BottomNavbarCubit>();
    btmNavBarCubit.startPageStackLister();
    btmNavBarCubit.initFloatingNavBarScrollBodyListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
      buildWhen: (previous, current) => current is! BtmNavBarShown && current is! BtmNavBarHidden,
      builder: (context, state) {
        return BottomNavLayout(
          pages: [
            (navKey) => const MenuScreen(title: "Home"),
            (navKey) => const MenuScreen(title: "Diary"),
            (navKey) => const MenuScreen(title: "Plan"),
            (navKey) => const ScrollingCommunityScreen(),
            (navKey) => const ScrollingProfileScreen(),
          ],
          bottomNavigationBar: (currentIndex, onTap) {
            return MainFloatingBottomNavBar(
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              currentIndex: currentIndex,
              height: 60.h,
              tabItems: [
                MainTabItem(
                  selected: currentIndex == 0,
                  selectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarHomeIconSelected",
                  unselectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarHomeIcon",
                  label: "Home",
                ),
                MainTabItem(
                  selected: currentIndex == 1,
                  selectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarDiaryIconSelected",
                  unselectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarDiaryIcon",
                  label: "Diary",
                ),
                MainTabItem(
                  selected: currentIndex == 2,
                  selectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarPlanIconSelected",
                  unselectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarPlanIcon",
                  label: "Plan",
                ),
                MainTabItem(
                  selected: currentIndex == 3,
                  selectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarCommunityIconSelected",
                  unselectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarCommunityIcon",
                  label: "Community",
                ),
                MainTabItem(
                  selected: currentIndex == 4,
                  selectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarProfileIconSelected",
                  unselectedPic: "MainAssetConstantsSvgs.ftsBtmNavbarProfileIcon",
                  label: "Profile",
                ),
              ],
              onItemTap: (index) {
                onTap(index);
              },
            );
          },
          savePageState: true,
          lazyLoadPages: true,
          pageStack: widget.myPageStack,
          extendBody: true,
          resizeToAvoidBottomInset: false,
        );
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightPurple,
      body: InkWell(
        onTap: () {
          if (title == 'Home') {
            context.read<BottomNavbarCubit>().bottomNavBarPushAuctionTab();
          } else if (title == 'Auctions') {
            context.read<BottomNavbarCubit>().bottomNavBarPushHomeTab();
          }
        },
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}

class ScrollingProfileScreen extends StatefulWidget {
  const ScrollingProfileScreen({super.key});

  @override
  State<ScrollingProfileScreen> createState() => _ScrollingProfileScreenState();
}

class _ScrollingProfileScreenState extends State<ScrollingProfileScreen> {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = context.read<BottomNavbarCubit>().searchTabController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightPurple,
      body: TweenAnimationBuilder(
          key: UniqueKey(),
          duration: 2.seconds,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value * context.width + (value * -50), 0),
              child: Scaffold(
                backgroundColor: AppColors.backgroundLightPurple,
                body: ListView.builder(
                    controller: _controller,
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          color: AppColors.primaryRed8AColor,
                          height: 50,
                          child: Center(
                              child: Text(
                            '$index',
                            style: AppTextStyles.px14wMedium(context).toPrimaryWhiteColor,
                          )),
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}

class ScrollingCommunityScreen extends StatefulWidget {
  const ScrollingCommunityScreen({super.key});

  @override
  State<ScrollingCommunityScreen> createState() => _ScrollingCommunityScreenState();
}

class _ScrollingCommunityScreenState extends State<ScrollingCommunityScreen> {
  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = context.read<BottomNavbarCubit>().notificationsTabController;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        itemCount: 100,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              color: AppColors.ramliColor,
              height: 50,
              child: Center(
                  child: Text(
                '$index',
                style: AppTextStyles.px14wMedium(context).toPrimaryWhiteColor,
              )),
            ),
          );
        });
  }
}
