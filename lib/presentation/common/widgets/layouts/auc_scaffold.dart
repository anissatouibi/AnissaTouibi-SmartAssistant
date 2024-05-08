import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold(
      {super.key,
      this.keepFocus = false,
      this.canPop = true,
      this.backgroundColor,
      this.extendBodyBehindAppBar = false,
      required this.body,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.appBarExtendedColor = AppColors.whiteColor,
      this.appBar,
      this.bottomPadding = true,
      this.safeAreaBottom = true});
  final bool keepFocus;
  final bool canPop;
  final Color? backgroundColor;
  final Color appBarExtendedColor;
  final bool extendBodyBehindAppBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool bottomPadding;
  final bool safeAreaBottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarExtendedColor,
      child: SafeArea(
        bottom: safeAreaBottom,
        child: Listener(

            /// unfocus when tapped outside
            behavior: HitTestBehavior.opaque,
            onPointerDown:
                keepFocus == true ? null : (_) => FocusManager.instance.primaryFocus?.unfocus(),
            child: WillPopScope(
                onWillPop: () => Future<bool>.value(canPop),
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: backgroundColor,
                    extendBodyBehindAppBar: extendBodyBehindAppBar,
                    bottomNavigationBar: bottomNavigationBar,
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: floatingActionButton,
                    appBar: appBar,
                    body: Padding(
                        padding: bottomPadding
                            ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                            : EdgeInsets.zero,
                        child: body)))),
      ),
    );
  }
}
