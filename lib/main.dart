import 'package:flutter/material.dart';
import 'package:flutter_cbt_dhani/data/datasources/local/onboarding_local_datasource.dart';
import 'package:flutter_cbt_dhani/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_cbt_dhani/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_cbt_dhani/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_cbt_dhani/presentation/auth/pages/login_page.dart';
import 'core/constants/colors.dart';
import 'presentation/onboarding/pages/onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter CBT FIC10',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.light,
        ),
        home: FutureBuilder(
          future: OnboardingLocalDatasource().getOnboardingStatus(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final bool visitedOnboarding = snapshot.hasData;
              debugPrint('visit : $visitedOnboarding');
              return visitedOnboarding
                  ? const LoginPage()
                  : const OnboardingPage();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
