import 'package:auto_route/auto_route.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:smart_assistant_app/presentation/common/widgets/checkbox/checkBox_widget.dart';
import 'package:smart_assistant_app/presentation/common/widgets/checkbox/checkbox_tile.dart';
import 'package:smart_assistant_app/presentation/common/widgets/layouts/fts_authentic_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_assistant_app/presentation/common/constants/assets_constants.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/images/auc_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsConsentContent extends StatelessWidget {
  const TermsAndConditionsConsentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAuthenticScaffold(
      withShadow: true,
      bgColor: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Terms & Conditions',
                        style: AppTextStyles.px24wSemiBold(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: AppTextStyles.px15wRegular(context).copyWith(height: 1.3.sp),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Acceptance of Terms: ',
                          style: AppTextStyles.px15wMedium(context).toPrimaryRedColor,
                        ),
                        const TextSpan(
                          text:
                              'By accessing or using Smart Assistant App, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use the App.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: AppTextStyles.px15wRegular(context).copyWith(height: 1.3.sp),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Use of the App: ',
                          style: AppTextStyles.px15wMedium(context).toPrimaryRedColor,
                        ),
                        const TextSpan(
                          text:
                              'You agree to use the App in accordance with all applicable laws and regulations. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: AppTextStyles.px15wRegular(context).copyWith(height: 1.3.sp),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Privacy: ',
                          style: AppTextStyles.px15wMedium(context).toPrimaryRedColor,
                        ),
                        const TextSpan(
                          text: 'Your privacy is important to us.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: TermsAgreementAndButtonSection()),
            Column(children: [
              SizedBox(height: 41.h),
            ]),
          ],
        ),
      ),
    );
  }
}

class TermsAgreementAndButtonSection extends StatefulWidget {
  const TermsAgreementAndButtonSection({
    super.key,
  });

  @override
  State<TermsAgreementAndButtonSection> createState() => _TermsAgreementAndButtonSectionState();
}

class _TermsAgreementAndButtonSectionState extends State<TermsAgreementAndButtonSection> {
  bool _termsChecked = false;
  bool _policyChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        CheckBoxTile(
          onChange: (terms) {
            _termsChecked = terms;
            setState(() {});
          },
          radio: true,
          text: 'I agree with the Terms & Conditions',
        ),
        CheckBoxTile(
          onChange: (policy) {
            _policyChecked = policy;
            setState(() {});
          },
          radio: true,
          text: 'I agree with smart assistant  Privacy Policy',
        ),
        const Spacer(),
        MainTextButton(
            onPressed: () {
              if (_policyChecked && _termsChecked) {
                print("push get started screen");
                context.router.pop();
              }
            },
            text: 'Accept'),
        const Spacer(),
      ],
    );
  }
}
