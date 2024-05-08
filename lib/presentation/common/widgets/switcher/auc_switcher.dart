import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/widgets/switcher/resources/myCupertinoSwitch.dart';
import 'package:flutter/material.dart';

class MainSwitcher extends StatefulWidget {
  final void Function(bool)? onChanged;
  final bool initialState;
  const MainSwitcher({super.key, required this.onChanged, required this.initialState});

  @override
  State<MainSwitcher> createState() => _MainSwitcherState();
}

class _MainSwitcherState extends State<MainSwitcher> {
  bool value = false;
  @override
  void initState() {
    super.initState();
    value = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MyCupertinoSwitch(
      trackColor: AppColors.greyLightEEEColor,
      activeColor: const Color(0xff852735).withOpacity(.08),
      thumbColor: value ? AppColors.primaryRed8AColor : AppColors.whiteColor,
      value: value,
      onChanged: (v) {
        setState(() => value = v);
        widget.onChanged!(v);
      },
    ));
  }
}
