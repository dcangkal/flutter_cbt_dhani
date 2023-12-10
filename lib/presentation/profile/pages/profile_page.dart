import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_dhani/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_dhani/presentation/home/pages/help_page.dart';
import 'package:flutter_cbt_dhani/presentation/home/pages/privacy_and_policy_page.dart';
import 'package:flutter_cbt_dhani/presentation/home/pages/term_of_service_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/custom_scaffold.dart';
import '../../../data/datasources/local/auth_local_datasource.dart';
import '../../../data/datasources/local/onboarding_local_datasource.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/pages/login_page.dart';
import '../../auth/widgets/logout_success_dialog.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // showBackButton: false,
      toolbarHeight: 110.0,
      appBarTitle: Row(
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
            width: context.deviceWidth - 250.0,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, Dhani',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '@codewithbahri',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.pushAndRemoveUntil(const LoginPage(), (route) => false);
            },
            icon: Assets.icons.logout.image(width: 24.0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          ProfileMenu(
            label: 'Edit Profile',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Help',
            onPressed: () {
              context.push(const HelpPage());
            },
          ),
          ProfileMenu(
            label: 'Privacy & Policy',
            onPressed: () {
              context.push(const PrivacyAndPolicyPage());
            },
          ),
          ProfileMenu(
            label: 'Term of Service',
            onPressed: () {
              context.push(const TermAOfServicePage());
            },
          ),
          const SizedBox(height: 16.0),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  success: () {
                    AuthLocalDatasource().removeAuth();
                    OnboardingLocalDatasource().resetOnboardStatus();
                    Future.delayed(const Duration(seconds: 2), () {
                      context.pushAndRemoveUntil(
                          const LoginPage(), (route) => false);
                    });
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
              return ProfileMenu(
                label: 'Logout',
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  // AuthLocalDatasource().removeAuth();
                  // context.pushReplacement(const LoginPage());
                },
              );
            },
          ),
          // ProfileMenu(
          //   label: 'Logout',
          //   onPressed: () {
          //     context.read<LogoutBloc>().add(const LogoutEvent.logout());
          //     AuthLocalDatasource().removeAuth();
          //     context.pushReplacement(const LoginPage());
          //   },
          // ),
        ],
      ),
    );
  }
}
