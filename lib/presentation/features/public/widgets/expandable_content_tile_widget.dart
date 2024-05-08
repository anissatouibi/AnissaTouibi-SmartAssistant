import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/utils/general_utils.dart';
import 'package:smart_assistant_app/presentation/common/widgets/expansion_tile/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableContentTileWidget extends StatelessWidget {
  const ExpandableContentTileWidget({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ExpansionTileCard(
        baseColor: AppColors.whiteColor,
        initialElevation: 0.0,
        elevation: 0.0,
        animateTrailing: true,
        shadowColor: Colors.transparent,
        trailing: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.primaryGreyA7Color,
            size: 24.sp,
          ),
        ),
        borderRadius: GeneralUtils.defaultBorderRadius(),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.px12wBold(context).toPrimaryRedColor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: const Color(0xffF6F5F5),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 13.h, bottom: 20.h),
                  child: Row(
                    children: [
                      Flexible(child: Text(content, style: AppTextStyles.px12wRegular(context))),
                      SizedBox(width: 16.w)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
