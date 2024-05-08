import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:smart_assistant_app/infrastructure/models/general/mainStatus.dart';
import 'package:smart_assistant_app/infrastructure/models/public/faq.dart';
import 'package:smart_assistant_app/presentation/common/theme/app_colors.dart';
import 'package:smart_assistant_app/presentation/common/utils/general_utils.dart';
import 'package:smart_assistant_app/presentation/common/widgets/appbars/auc_pop_sliver_appbar.dart';
import 'package:smart_assistant_app/presentation/common/widgets/layouts/auc_scaffold.dart';
import 'package:smart_assistant_app/presentation/features/public/cubit/public_data_cubit.dart';
import 'package:smart_assistant_app/presentation/features/public/widgets/expandable_content_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqContent extends StatelessWidget {
  const FaqContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarExtendedColor: AppColors.whiteColor,
      body: CustomScrollView(slivers: [
        const MainPopSliverAppBar(
          title: "context.t.drawer_items.faq_page.faq",
          backgroundColor: AppColors.whiteColor,
        ),
        BlocBuilder<PublicDataCubit, PublicDataState>(
          builder: (context, state) {
            if (state.mainStatus == MainStatus.loaded) {
              return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 21.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(children: [
                      for (FAQ faq in state.data!.faqs)
                        ExpandableContentTileWidget(
                          title: GeneralUtils.trField(context,
                              textAr: faq.questionAr, textEn: faq.questionEn),
                          content: GeneralUtils.trField(context,
                              textAr: faq.answerAr, textEn: faq.answerEn),
                        ),
                    ]),
                  ));
            }
            return SliverToBoxAdapter(child: SizedBox.fromSize());
          },
        ),
      ]),
    );
  }
}
