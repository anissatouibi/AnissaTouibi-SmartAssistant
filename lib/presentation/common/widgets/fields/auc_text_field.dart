import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.hintText,
    this.prefixWidget,
    this.suffixWidget,
    this.controller,
    this.hintStyle,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputType = TextInputType.text,
    this.obscure = false,
    this.widePrefix = false,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.maxLines = 1,
    this.inputFormatters,
    this.fillColor,
    this.textAlign,
    this.inputBorder,
    this.contentPadding,
    this.textStyle,
    this.textAlignVertical,
    this.labelText,
    this.textDirection,
    this.readOnly = false,
    this.cursorHeight,
    this.onTap,
    this.errorBorder,
    this.autoFocus = false,
  });
  final String? hintText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final bool obscure;
  final bool widePrefix;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextAlign? textAlign;
  final InputBorder? inputBorder;
  final InputBorder? errorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextAlignVertical? textAlignVertical;
  final String? labelText;
  final TextDirection? textDirection;
  final bool readOnly;
  final double? cursorHeight;
  final GestureTapCallback? onTap;
  final bool autoFocus;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool fieldFocused = false;
  bool obscuring = false;

  @override
  void initState() {
    obscuring = widget.obscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 42.h),
      child: Focus(
        onFocusChange: (value) {
          fieldFocused = value;
          setState(() {});
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AbsorbPointer(
            absorbing: widget.onTap != null,
            child: TextFormField(
                autofocus: widget.autoFocus,
                readOnly: widget.readOnly,
                textDirection: widget.textDirection,
                autocorrect: false,
                validator: widget.validator,
                autovalidateMode: widget.autovalidateMode,
                obscureText: obscuring,
                scrollPadding: EdgeInsets.only(bottom: 30.h),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: widget.labelText,
                  labelStyle: AppTextStyles.px14wBold(context).copyWith(
                      fontSize: fieldFocused ? 14.sp : 12.sp,
                      fontWeight: fieldFocused ? FontWeight.w700 : FontWeight.w400,
                      color: !fieldFocused ? AppColors.primaryGreyA7Color : null),
                  enabledBorder: widget.inputBorder,
                  disabledBorder: widget.inputBorder,
                  focusedBorder: widget.inputBorder,
                  border: widget.inputBorder,
                  errorBorder: widget.errorBorder,
                  filled: true,
                  hintStyle:
                      widget.hintStyle ?? AppTextStyles.px12wRegular(context).toPrimaryGreyColor,
                  hintText: widget.hintText,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 18.w),
                  fillColor: widget.fillColor,
                  focusColor: widget.fillColor,
                  prefixIcon: widget.widePrefix
                      ? widget.prefixWidget
                      : widget.prefixWidget != null
                          ? IconButton(icon: widget.prefixWidget!, onPressed: () {})
                          : null,
                  suffixIcon: widget.obscure
                      ? GestureDetector(
                          onTap: () => setState(() => obscuring = !obscuring),
                          child: Icon(
                            obscuring ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.primaryGreyA7Color,
                            size: 23.sp,
                          ),
                        )
                      : widget.suffixWidget,
                ),
                textAlignVertical: widget.textAlignVertical,
                textAlign: widget.textAlign ?? TextAlign.start,
                controller: widget.controller,
                onChanged: widget.onChanged,
                textInputAction: widget.textInputAction,
                cursorHeight: widget.cursorHeight ?? 18.h,
                cursorWidth: 1.0,
                style: widget.textStyle ?? AppTextStyles.px12wRegular(context),
                focusNode: widget.focusNode,
                onFieldSubmitted: widget.onFieldSubmitted,
                keyboardType: widget.textInputType,
                maxLines: widget.maxLines,
                inputFormatters: widget.inputFormatters),
          ),
        ),
      ),
    );
  }
}
