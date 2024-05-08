part of 'bottom_nav_bar_cubit.dart';

@freezed
class BottomNavbarState with _$BottomNavbarState {
  const factory BottomNavbarState.initial() = BtmNavInitial;
  const factory BottomNavbarState.processing() = BtmNavProcessing;
  const factory BottomNavbarState.screenPushed(int pageIndex) = ScreenPushed;
  const factory BottomNavbarState.btmNavBarShown() = BtmNavBarShown;
  const factory BottomNavbarState.btmNavBarHidden() = BtmNavBarHidden;
}
