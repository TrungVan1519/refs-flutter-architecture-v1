import 'package:base_app/core/utils/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingNotifier extends StateNotifier<String> {
  AppSettingNotifier()
      : super(AppConstants.supportedLocales.first.languageCode);

  void setLangCode(String langCode) {
    state = langCode;
  }
}

final nodAppSetting = StateNotifierProvider<AppSettingNotifier, String>((ref) {
  return AppSettingNotifier();
});
