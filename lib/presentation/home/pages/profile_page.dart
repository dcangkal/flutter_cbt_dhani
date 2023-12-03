import 'package:flutter/material.dart';
import 'package:flutter_cbt_dhani/presentation/home/widgets/header_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HeaderProfile(),
          SizedBox(height: 24.0),
          // TitleSection(
          //   title: 'Profile',
          //   onSeeAllTap: () {},
          // ),
          // const SizedBox(height: 16.0),
          // GridView(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 16.0,
          //     mainAxisSpacing: 24.0,
          //   ),
          //   children: [
          //     MenuHome(
          //       imagePath: Assets.images.menu.aboutUs.path,
          //       label: 'About Us',
          //       onPressed: () {
          //         // context.push(const AboutUsPage());
          //       },
          //     ),
          //     MenuHome(
          //       imagePath: Assets.images.menu.tips.path,
          //       label: 'Tips & Tricks ',
          //       onPressed: () {
          //         // context.push(const TipsAndTricksPage());
          //       },
          //     ),
          //     MenuHome(
          //       imagePath: Assets.images.menu.materi.path,
          //       label: 'Materi',
          //       onPressed: () {
          //         // context.push(const MateriPage());
          //       },
          //     ),
          //     MenuHome(
          //       imagePath: Assets.images.menu.quiz.path,
          //       label: 'Quiz',
          //       onPressed: () {
          //         // context.push(const QuizListPage());
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
