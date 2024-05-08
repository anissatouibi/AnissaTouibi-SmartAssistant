import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_text_styles.dart';
import 'package:smart_assistant_app/presentation/common/widgets/checkbox/checkBox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxTile extends StatefulWidget {
  const CheckBoxTile({
    super.key,
    required this.text,
    this.initiallyChecked = false,
    this.enabled = true,
    required this.onChange,
    this.radio = false,
  });

  final String text;
  final bool initiallyChecked;
  final bool enabled;
  final bool radio;
  final ValueChanged<bool> onChange;

  @override
  _CheckBoxTileState createState() => _CheckBoxTileState();
}

class _CheckBoxTileState extends State<CheckBoxTile> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initiallyChecked;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.enabled) {
          isChecked = !isChecked;
          widget.onChange(isChecked);
          setState(() {});
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainCheckboxWidget(
            key: ValueKey(isChecked),
            initialState: isChecked,
            checkable: widget.enabled,
            radio: widget.radio,
            onChange: (value) {
              setState(() {
                isChecked = value;
              });
              widget.onChange(value);
            },
            fillColor: AppColors.ramliColor,
            uncheckedFillColor: AppColors.whiteColor,
          ),
          SizedBox(width: 3.w),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Text(
                widget.text,
                style: AppTextStyles.px12wRegular(context)
                    .copyWith(color: !widget.enabled ? AppColors.primaryGreyA7Color : null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
