import 'package:auto_route/auto_route.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:smart_assistant_app/presentation/common/widgets/checkbox/checkBox_widget.dart';
import 'package:smart_assistant_app/presentation/common/widgets/fields/auc_text_field.dart';
import 'package:smart_assistant_app/presentation/common/widgets/radiobox/radio_box_widget.dart';
import 'package:smart_assistant_app/presentation/common/widgets/switcher/auc_switcher.dart';
import 'package:flutter/material.dart';
import 'package:smart_assistant_app/presentation/common/widgets/layouts/fts_authentic_scaffold.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CommonWidgetsPage extends StatelessWidget {
  const CommonWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAuthenticScaffold(
      bgColor: AppColors.backgroundLightPurple,
      withShadow: true,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MainTextField(hintText: "E-mail address"),
              ),
              SizedBox(height: 30.h),
              MainSwitcher(
                onChanged: (value) {},
                initialState: true,
              ),
              SizedBox(height: 30.h),
              MainCheckboxWidget(
                onChange: (value) {},
                initialState: true,
                radio: true,
                fillColor: AppColors.ramliColor,
              ),
              SizedBox(height: 30.h),
              MainRadioBoxWidget(itemValue: 1, currentValue: 1, onChanged: (val) {}),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: MainTextButton(
                  onPressed: () {},
                  text: 'Connect',
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
