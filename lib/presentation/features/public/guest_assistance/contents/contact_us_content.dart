import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/utils/validators/field_validation.dart';
import 'package:smart_assistant_app/presentation/common/widgets/appbars/auc_pop_appbar.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:smart_assistant_app/presentation/common/widgets/clippers/auc_diagonal_clipper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/fields/auc_text_field.dart';
import 'package:smart_assistant_app/presentation/common/widgets/layouts/auc_scaffold.dart';
import 'package:smart_assistant_app/presentation/features/public/cubit/public_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

class ContactUsContent extends StatefulWidget {
  const ContactUsContent({super.key});

  @override
  State<ContactUsContent> createState() => _ContactUsContentState();
}

class _ContactUsContentState extends State<ContactUsContent> {
  bool attemptedSubmit = false;
  late TextEditingController _emailTec;
  late TextEditingController _subjectTec;
  late TextEditingController _messageTec;

  late FocusNode _emailFcNode;
  late FocusNode _subjectFcNode;
  late FocusNode _messageFcNode;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    _emailTec = TextEditingController();
    _subjectTec = TextEditingController();
    _messageTec = TextEditingController();

    _emailFcNode = FocusNode();
    _subjectFcNode = FocusNode();
    _messageFcNode = FocusNode();

    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _subjectTec.dispose();
    _messageTec.dispose();
    _emailFcNode.dispose();
    _subjectFcNode.dispose();
    _messageFcNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBarExtendedColor: AppColors.whiteColor,
        appBar: const MainPopAppBar(
            title: "context.t.drawer_items.contactUs_page.contact_us",
            backgroundColor: AppColors.whiteColor),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: Padding(
            padding: EdgeInsets.only(bottom: 36.h),
            child: MainTextButton(
              height: 44.h,
              text: t.common.send,
              onPressed: () {
                setState(
                  () => attemptedSubmit = true,
                );
                if (formKey.currentState!.validate()) {}
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Padding(
              padding: EdgeInsets.only(top: 21.h),
              child: MainDiagonalCLipper(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 9.w),
                  child: Form(
                    key: formKey,
                    autovalidateMode: attemptedSubmit ? AutovalidateMode.always : null,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      MainTextField(
                        labelText: "t.drawer_items.contactUs_page.email",
                        fillColor: AppColors.whiteColor,
                        controller: _emailTec,
                        focusNode: _emailFcNode,
                        onFieldSubmitted: (_) => _subjectFcNode.requestFocus(),
                        validator: ValidationBuilder(requiredMessage: t.errors.fields.required)
                            .isValidEmail(invalidEmailMsg: t.errors.fields.input(field: "email"))
                            .build(),
                      ),
                      SizedBox(height: 10.h),
                      MainTextField(
                        labelText: "Subject",
                        fillColor: AppColors.whiteColor,
                        controller: _subjectTec,
                        focusNode: _subjectFcNode,
                        onFieldSubmitted: (_) => _messageFcNode.requestFocus(),
                        validator:
                            ValidationBuilder(requiredMessage: t.errors.fields.required).build(),
                      ),
                      SizedBox(height: 10.h),
                      MainTextField(
                        labelText: "Message",
                        fillColor: AppColors.whiteColor,
                        controller: _messageTec,
                        focusNode: _messageFcNode,
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 9,
                        validator:
                            ValidationBuilder(requiredMessage: t.errors.fields.required).build(),
                      ),
                      SizedBox(height: 10.h),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
