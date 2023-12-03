import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_dhani/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_dhani/data/datasources/local/auth_local_datasource.dart';
import 'package:flutter_cbt_dhani/data/datasources/local/onboarding_local_datasource.dart';
import 'package:flutter_cbt_dhani/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_cbt_dhani/presentation/auth/pages/login_page.dart';
import 'package:flutter_cbt_dhani/presentation/auth/widgets/logout_success_dialog.dart';
import '../../../core/constants/colors.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: Image.network(
                  'https://i.pravatar.cc/200',
                  width: 64.0,
                  height: 64.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: context.deviceWidth - 208.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FutureBuilder(
                      future: AuthLocalDatasource().getAuth(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      success: () {
                        AuthLocalDatasource().removeAuth();
                        OnboardingLocalDatasource().resetOnboardStatus();
                        Future.delayed(
                          const Duration(seconds: 2),
                          () => context.pushReplacement(
                            const LoginPage(),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const LogoutSuccessDialog();
                          },
                        );
                      },
                      error: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('logout error'),
                          ),
                        );
                      });
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<LogoutBloc>().add(
                            const LogoutEvent.logout(),
                          );
                    },
                    icon: Container(
                      width: 40.0,
                      height: 40.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: const Icon(Icons.logout),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
