import 'dart:developer';

import 'package:smart_assistant_app/injection.dart';

import 'package:bloc/bloc.dart';
import 'package:smart_assistant_app/presentation/features/bottom_nav_layout_manager.dart/widgets/BottomNavLayoutResources/page_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
part 'bottom_nav_bar_state.dart';
part 'bottom_nav_bar_cubit.freezed.dart';

@injectable
class BottomNavbarCubit extends Cubit<BottomNavbarState> {
  final ReorderToFrontPageStack myPageStack;

  BottomNavbarCubit(this.myPageStack) : super(const BottomNavbarState.initial());
  int _currentPageStackIndex = 2;

  int get currentPageStackIndex => _currentPageStackIndex;
  // navbar scroll control
  ScrollController bottomBarBodyScrollController = ScrollController();
  final ScrollController searchTabController = ScrollController();
  final ScrollController notificationsTabController = ScrollController();

  bool isScrollingDown = false;
  bool isOnTop = true;

  bottomNavBarPushAuctionTab() {
    myPageStack.push(0);
    emit(const BottomNavbarState.processing());
    emit(const BottomNavbarState.screenPushed(0));
  }

  bottomNavBarPushHomeTab() {
    myPageStack.push(2);
    emit(const BottomNavbarState.processing());
    emit(const BottomNavbarState.screenPushed(2));
  }

  startPageStackLister() {
    myPageStack.onPageChange.listen((x) {
      _currentPageStackIndex = x;
      manageTabChangeScrollListeners();
    });
  }

  // manage tabs scrollers on page stack change
  manageTabChangeScrollListeners() {
    if (_currentPageStackIndex == 3) {
      bottomBarBodyScrollController = notificationsTabController;
      restartScrollListener();
    } else if (_currentPageStackIndex == 4) {
      bottomBarBodyScrollController = searchTabController;
      restartScrollListener();
    }
  }

  // on tab change, general scroller gets the focused screen scroller so general listener has to be restarted
  restartScrollListener() {
    bottomBarBodyScrollController.removeListener(_listener);
    initFloatingNavBarScrollBodyListener();
  }

  // bottom nav bar animation control fire listener
  initFloatingNavBarScrollBodyListener() {
    bottomBarBodyScrollController.addListener(_listener);
  }

  void _listener() {
    // log('in scroll listener');
    if (bottomBarBodyScrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (!isScrollingDown) {
        isScrollingDown = true;
        isOnTop = false;
        // emit(const BottomNavbarState.processing());
        emit(const BottomNavbarState.btmNavBarHidden());
      }
    }
    if (bottomBarBodyScrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (isScrollingDown) {
        isScrollingDown = false;
        isOnTop = true;
        // emit(const BottomNavbarState.processing());
        emit(const BottomNavbarState.btmNavBarShown());
      }
    }
  }

  @override
  Future<void> close() async {
    super.close();
    bottomBarBodyScrollController.removeListener(_listener);
    bottomBarBodyScrollController.dispose();
  }
}
