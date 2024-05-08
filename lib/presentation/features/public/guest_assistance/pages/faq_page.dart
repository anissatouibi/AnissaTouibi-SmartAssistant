import 'package:smart_assistant_app/presentation/features/public/guest_assistance/contents/faq_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FaqContent();
  }
}
