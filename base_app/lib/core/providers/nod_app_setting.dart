import 'package:base_app/core/storage/local/app_local_storage.dart';
import 'package:base_app/core/utils/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingNotifier extends StateNotifier<String> {
  AppSettingNotifier()
      : super(AppConstants.supportedLocales.first.languageCode);

  void setLangCode(String langCode) {
    AppLocalStorage.instance.set(AppConstants.appLang, langCode);
    state = langCode;
  }
}

final nodAppSetting = StateNotifierProvider<AppSettingNotifier, String>((ref) {
  return AppSettingNotifier();
});
