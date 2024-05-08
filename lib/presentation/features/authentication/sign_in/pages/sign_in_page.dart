import 'package:smart_assistant_app/injection.dart';
import 'package:smart_assistant_app/presentation/features/Authentication/Sign_in/contents/sign_in_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:smart_assistant_app/presentation/features/authentication/sign_in/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const SignInContent(),
    );
  }
}
