import 'package:smart_assistant_app/core/app.dart';
import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/infrastructure/models/general/cubitStatus.dart';
import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:smart_assistant_app/presentation/common/cubit/auth/auth_cubit.dart';
import 'package:smart_assistant_app/presentation/common/routes/router.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/bottom_sheet/operation_status_sheet.dart';
import 'package:smart_assistant_app/presentation/common/widgets/buttons/auc_text_button.dart';
import 'package:smart_assistant_app/presentation/common/widgets/fields/auc_text_field.dart';
import 'package:smart_assistant_app/presentation/common/widgets/fields/phone_text_field_suffix.dart';
import 'package:smart_assistant_app/presentation/common/widgets/layouts/auc_authentic_scaffold.dart';
import 'package:smart_assistant_app/presentation/common/widgets/overlays/auc_loading_overlay.dart';
import 'package:smart_assistant_app/presentation/features/authentication/sign_in/cubit/login_cubit.dart';
import 'package:smart_assistant_app/presentation/features/user_portal/cubit/profile/cubit/user_profile_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

class SignInContent extends StatefulWidget {
  const SignInContent({super.key});

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent> {
  bool attemptedSubmit = false;
  late TextEditingController _phoneTec;
  late TextEditingController _passTec;

  late FocusNode _phoneFcNode;
  late FocusNode _passFcNode;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    _phoneTec = TextEditingController();
    _passTec = TextEditingController();

    _phoneFcNode = FocusNode();
    _passFcNode = FocusNode();

    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _phoneTec.dispose();
    _passTec.dispose();

    _phoneFcNode.dispose();
    _passFcNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.read<LoginCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous.status?.statusType != current.status?.statusType,
          listener: (context, state) {
            if (state.status?.action == CubitAction.phoneSignIn) {
              if (state.status!.statusType == CubitStatusType.success) {
                context.read<AuthCubit>().requestAuthCheck();
              } else {
                BottomSheetHelper.showStatusSheet(
                    text: state.status!.errorMsg!,
                    statusType: SheetStatusType.failure,
                    context: context,
                    overlayDelayed: true);
              }
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.read<UserProfileCubit>().getAccountCurrentProfile();
            } else if (state is Unauthenticated) {
              BottomSheetHelper.showStatusSheet(
                text: state.errorMessage!,
                statusType: SheetStatusType.failure,
                context: context,
                overlayDelayed: true,
              );
            }
          },
        ),
        BlocListener<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state.mainStatus == MainStatus.loaded) {
              context.router.pop();
            } else if (state.mainStatus == MainStatus.failure) {}
          },
        ),
      ],
      child: BlocSelector<LoginCubit, LoginState, bool>(
        selector: (state) {
          return state.status?.statusType == CubitStatusType.loading;
        },
        builder: (context, isSigningIn) {
          return BlocSelector<AuthCubit, AuthState, bool>(
            selector: (state) {
              return state is Checking;
            },
            builder: (context, isAuthenticating) {
              return BlocSelector<UserProfileCubit, UserProfileState, bool>(
                selector: (state) {
                  return state.mainStatus == MainStatus.loading;
                },
                builder: (context, isFetchingProfile) {
                  return MainLoadingOverlay(
                    active: isSigningIn || isAuthenticating || isFetchingProfile,
                    child: MainAuthenticScaffold(
                      withBackBtn: true,
                      withBottomDesign: true,
                      withBottomLogo: true,
                      resizeToAvoidBottomInset: false,
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Column(
                            children: [
                              SizedBox(height: 56.h),
                              Row(
                                children: [
                                  Text(
                                    "Sign in",
                                    style: AppTextStyles.px28wBold(context)
                                        .copyWith(color: Theme.of(context).colorScheme.primary),
                                  ),
                                ],
                              ),
                              SizedBox(height: 35.h),
                              Builder(builder: (context) {
                                final isArabic = context.isArabic;
                                return MainTextField(
                                  textAlign: TextAlign.start,
                                  labelText: "Phone",
                                  controller: _phoneTec,
                                  focusNode: _phoneFcNode,
                                  onFieldSubmitted: (_) => _passFcNode.requestFocus(),
                                  textInputType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(8),
                                  ],
                                  validator: ValidationBuilder(
                                          requiredMessage: t.errors.fields.enter(field: "Phone"))
                                      .minLength(
                                          8, t.errors.fields.input(field: "Phone")) //"400.49546"
                                      .build(),
                                  autovalidateMode:
                                      attemptedSubmit ? AutovalidateMode.always : null,
                                  widePrefix: !isArabic ? true : false,
                                  textInputAction: TextInputAction.next,
                                );
                              }),
                              SizedBox(height: 8.h),
                              MainTextField(
                                labelText: "Password",
                                obscure: true,
                                controller: _passTec,
                                focusNode: _passFcNode,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                ],
                                validator: ValidationBuilder(
                                        requiredMessage:
                                            t.errors.fields.requiredField(field: "Password"))
                                    .minLength(
                                        4, t.errors.fields.minChar(field: "Password", min: 4))
                                    .maxLength(
                                        20, t.errors.fields.maxChar(field: "Password", max: 20))
                                    .build(),
                                autovalidateMode: attemptedSubmit ? AutovalidateMode.always : null,
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Forgot password",
                                      style: AppTextStyles.px12wRegular(context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 23.h),
                              MainTextButton(
                                text: context.t.common.save,
                                onPressed: () async {
                                  if (!attemptedSubmit) {
                                    setState(() {
                                      attemptedSubmit = true;
                                    });
                                  }
                                  if (formKey.currentState!.validate()) {
                                    await Future.delayed(const Duration(milliseconds: 500));

                                    signInCubit.signInPressed(
                                        phone: _phoneTec.text, password: _passTec.text);
                                  }
                                },
                              ),
                              SizedBox(height: 48.h),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Create account",
                                  style: AppTextStyles.px12wBold(context).copyWith(
                                      color: Theme.of(context).colorScheme.secondary,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
