import 'package:smart_assistant_app/presentation/common/widgets/animators/bounce_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCustomCheckBox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool> onChanged;
  final Color checkedIconColor;
  final Color checkedFillColor;
  final IconData checkedIcon;
  final Color uncheckedIconColor;
  final Color uncheckedFillColor;
  final IconData? uncheckedIcon;
  final double? borderWidth;
  final double? checkBoxSize;
  final bool shouldShowBorder;
  final Color? borderColor;
  final double? borderRadius;
  final bool checkable;
  final bool uncheckable;

  const MyCustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.checkedIconColor = Colors.white,
    this.checkedFillColor = Colors.teal,
    this.checkedIcon = Icons.check,
    this.uncheckedIconColor = Colors.white,
    this.uncheckedFillColor = Colors.white,
    this.uncheckedIcon = Icons.close,
    this.borderWidth,
    this.checkBoxSize,
    this.shouldShowBorder = false,
    this.borderColor,
    this.borderRadius,
    this.checkable = true,
    this.uncheckable = true,
  });

  @override
  _MyCustomCheckBoxState createState() => _MyCustomCheckBoxState();
}

class _MyCustomCheckBoxState extends State<MyCustomCheckBox> {
  bool? _checked;
  CheckStatus? _status;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(MyCustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  void _init() {
    _checked = widget.value;
    if (_checked!) {
      _status = CheckStatus.checked;
    } else {
      _status = CheckStatus.unchecked;
    }
  }

  Widget _buildIcon() {
    Color? fillColor;
    Color? iconColor;
    IconData? iconData;

    switch (_status!) {
      case CheckStatus.checked:
        fillColor = widget.checkedFillColor;
        iconColor = widget.checkedIconColor;
        iconData = widget.checkedIcon;
        break;
      case CheckStatus.unchecked:
        fillColor = widget.uncheckedFillColor;
        iconColor = widget.uncheckedIconColor;
        iconData = widget.uncheckedIcon;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 6)),
        border: Border.all(
          color: widget.shouldShowBorder ? widget.borderColor! : widget.checkedFillColor,
          width: widget.shouldShowBorder ? widget.borderWidth! : 2.sp,
        ),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: widget.checkBoxSize ?? 18.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: () {
        if (_checked == true) {
          if (widget.uncheckable) widget.onChanged(!_checked!);
        } else {
          if (widget.checkable) widget.onChanged(!_checked!);
        }
      },
      duration: const Duration(milliseconds: 150),
      child: IconButton(
        onPressed: null,
        icon: _buildIcon(),
        padding: const EdgeInsets.all(2.0),
      ),
    );
  }
}

enum CheckStatus {
  checked,
  unchecked,
}
