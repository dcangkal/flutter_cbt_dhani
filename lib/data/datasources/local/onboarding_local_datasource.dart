import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDatasource {
  Future<void> setOnboardingStatus() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('visited_onboarding', true);
  }

  Future<bool> getOnboardingStatus() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('visited_onboarding') ?? false;
  }

  Future<void> resetOnboardStatus() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('visited_onboarding', false);
  }
}
