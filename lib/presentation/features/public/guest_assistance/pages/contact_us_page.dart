import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/infrastructure/models/general/cubitStatus.dart';
import 'package:smart_assistant_app/presentation/common/utils/bottomSheet/BottomSheetHelper.dart';
import 'package:smart_assistant_app/presentation/common/widgets/bottom_sheet/operation_status_sheet.dart';
import 'package:smart_assistant_app/presentation/common/widgets/overlays/auc_loading_overlay.dart';
import 'package:smart_assistant_app/presentation/features/public/cubit/public_data_cubit.dart';
import 'package:smart_assistant_app/presentation/features/public/guest_assistance/contents/contact_us_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PublicDataCubit, PublicDataState>(
      listener: (context, state) async {
        if (state.status?.action == CubitAction.contactUs) {
          if (state.status?.statusType == CubitStatusType.success) {
            BottomSheetHelper.showStatusSheet(
                text: context.t.messages.message_sent,
                statusType: SheetStatusType.success,
                context: context,
                overlayDelayed: true);
            await Future.delayed(const Duration(milliseconds: 2800));
            // ignore: use_build_context_synchronously
            context.router.popUntil((route) => route.isFirst);
          } else if (state.status?.statusType == CubitStatusType.failure) {
            BottomSheetHelper.showStatusSheet(
              text: state.status!.errorMsg!,
              statusType: SheetStatusType.failure,
              context: context,
            );
          }
        }
      },
      child: BlocSelector<PublicDataCubit, PublicDataState, bool>(selector: (state) {
        return state.status?.action == CubitAction.contactUs &&
            state.status?.statusType == CubitStatusType.loading;
      }, builder: (context, isSending) {
        return MainLoadingOverlay(active: isSending, child: const ContactUsContent());
      }),
    );
  }
}
