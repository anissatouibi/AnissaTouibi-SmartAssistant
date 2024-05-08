import 'dart:io';

import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/cubit/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/features/bottom_nav_layout_manager.dart/models/tabItem.dart';
import 'package:smart_assistant_app/presentation/features/bottom_nav_layout_manager.dart/widgets/CustomRowBottomNavBar.dart/BottomTabItem.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainFloatingBottomNavBar extends StatefulWidget {
  final double height;
  final int currentIndex;
  final ValueChanged<int> onItemTap;
  final List<MainTabItem> tabItems;
  final Color backgroundColor;
  const MainFloatingBottomNavBar({
    super.key,
    required this.height,
    required this.currentIndex,
    required this.onItemTap,
    required this.tabItems,
    required this.backgroundColor,
  }) : assert(currentIndex >= 0 && currentIndex < tabItems.length);

  @override
  State<MainFloatingBottomNavBar> createState() => _MainFloatingBottomNavBarState();
}

class _MainFloatingBottomNavBarState extends State<MainFloatingBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationcontroller;
  late Animation<Offset> _offsetAnimation;
  bool isScrollingDown = false;
  bool isOnTop = true;

  @override
  void initState() {
    super.initState();

    _animationcontroller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2),
    ).animate(CurvedAnimation(
      parent: _animationcontroller,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  void showBottomBar() {
    setState(() {
      _animationcontroller.reverse();
    });
  }

  void hideBottomBar() {
    setState(() {
      _animationcontroller.forward();
    });
  }

  @override
  void dispose() {
    _animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavbarCubit, BottomNavbarState>(
      listenWhen: (previous, current) =>
          previous != current && (current is BtmNavBarShown || current is BtmNavBarHidden),
      listener: (context, state) {
        if (state is BtmNavBarShown) {
          showBottomBar();
        } else if (state is BtmNavBarHidden) {
          hideBottomBar();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            width: context.width,
            height: 120.h,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.0,
                  1.0,
                ],
                colors: [
                  Colors.white.withOpacity(0.0),
                  const Color(0xff9B9999).withOpacity(0.46),
                ],
              )),
            ),
          ),
          Positioned(
            bottom: 14.h,
            width: context.width,
            child: SlideTransition(
              position: _offsetAnimation,
              child: NavBarContent(
                  height: widget.height,
                  backgroundColor: widget.backgroundColor,
                  tabItems: widget.tabItems,
                  onItemTap: widget.onItemTap),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarContent extends StatelessWidget {
  const NavBarContent({
    super.key,
    required this.height,
    required this.backgroundColor,
    required this.tabItems,
    required this.onItemTap,
  });

  final double height;
  final Color backgroundColor;
  final List<MainTabItem> tabItems;
  final ValueChanged<int> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        height: height * 1.3333,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
            Positioned.fill(
              left: 27.w,
              right: 27.w,
              child: Container(
                // color: Colors.black,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tabItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      final tabItem = entry.value;
                      return Expanded(
                        child: InkWell(
                          onTap: () => onItemTap(index),
                          child: AnimatedSwitcher(
                            duration: 100.ms,
                            reverseDuration: Duration.zero,
                            switchInCurve: Curves.easeInCubic,
                            switchOutCurve: Curves.easeOutCubic,
                            transitionBuilder: (child, animation) {
                              if (child.key == const ValueKey(true)) {
                                final animationTween =
                                    Tween<double>(begin: 0.64, end: 1.0).animate(animation);

                                return FadeTransition(
                                  opacity: animationTween,
                                  child: ScaleTransition(
                                    scale: animationTween,
                                    child: child,
                                  ),
                                );
                              } else {
                                return child;
                              }
                            },
                            child: tabItem.selected
                                ? KeyedSubtree(
                                    key: const ValueKey(true),
                                    child: BNavBarItemSelected(
                                      selectedPic: tabItem.selectedPic,
                                      unselectedPic: tabItem.unselectedPic,
                                      label: tabItem.label,
                                    ),
                                  )
                                : BNavBarItem(
                                    selected: tabItem.selected,
                                    selectedPic: tabItem.selectedPic,
                                    unselectedPic: tabItem.unselectedPic,
                                    label: tabItem.label,
                                  ),
                          ),
                        ),
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
