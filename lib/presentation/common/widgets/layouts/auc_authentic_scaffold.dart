import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:smart_assistant_app/presentation/features/Authentication/widgets/AuthenticBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAuthenticScaffold extends StatelessWidget {
  const MainAuthenticScaffold({
    super.key,
    required this.child,
    this.withBottomDesign = false,
    this.withBottomLogo = false,
    this.withTopLogo = true,
    this.withBackBtn = false,
    this.resizeToAvoidBottomInset = true,
    this.bottomNavigationBar,
    this.unfocusOnTapOut = true,
  });
  final Widget child;
  final bool withBottomDesign;
  final bool withBottomLogo;
  final bool withTopLogo;
  final bool withBackBtn;
  final bool resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;
  final bool unfocusOnTapOut;

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;
    return Listener(
      /// unfocus when tapped outside
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => unfocusOnTapOut ? FocusManager.instance.primaryFocus?.unfocus() : null,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        bottomNavigationBar: bottomNavigationBar,
        body: Column(
          children: [
            Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              child: Stack(
                children: [
                  MainSvgImage(
                    path: "MainAssetConstantsSvgs.aucBiddingBgMotif",
                    darkPath: "MainAssetConstantsSvgs.aucBiddingBgMotifDark",
                    fit: BoxFit.cover,
                    height: 126.h,
                    width: screenWidth,
                  ),
                  Positioned(
                    bottom: 0,
                    width: screenWidth,
                    height: 70.h,
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
                          AppColors.whiteColor.withOpacity(0.0),
                          AppColors.whiteColor,
                        ],
                      )),
                    ),
                  ),
                  if (withBackBtn) const AuthenticBackButton()
                ],
              ),
            ),
            if (withTopLogo)
              Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    MainSvgImage(
                      path: "MainAssetConstantsSvgs.aucMazadWQatarCustomsLogos2",
                      darkPath: "MainAssetConstantsSvgs.aucMazadWQatarCustomsLogos2",
                      height: 45.h,
                      width: 260.w,
                    ),
                    SizedBox(height: 18.h),
                  ],
                ),
              ),
            Expanded(child: child),
            if (withBottomDesign || withBottomLogo)
              Stack(
                children: [
                  if (withBottomDesign)
                    Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: MainSvgImage(
                            path: "MainAssetConstantsSvgs.aucBiddingBgMotif",
                            darkPath: "MainAssetConstantsSvgs.aucBiddingBgMotifDark",
                            fit: BoxFit.cover,
                            height: 126.h,
                            width: screenWidth,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          width: screenWidth,
                          height: 70.h,
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
                                AppColors.whiteColor,
                                AppColors.whiteColor.withOpacity(0.0),
                              ],
                            )),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      height: 129.h,
                      width: screenWidth,
                    ),
                  if (withBottomLogo)
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.t.common.powered_by,
                            style: AppTextStyles.px12wRegular(context),
                          ),
                          MainSvgImage(
                            path: "MainAssetConstantsSvgs.aucTasmouWMinistryLogos",
                            darkPath: "MainAssetConstantsSvgs.aucTasmouWMinistryLogosDark",
                            width: 134.w,
                            height: 70.h,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
