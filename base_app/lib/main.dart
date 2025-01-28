import 'package:base_app/core/extensions/stringx.dart';
import 'package:base_app/core/providers/nod_app_setting.dart';
import 'package:base_app/core/storage/local/app_local_storage.dart';
import 'package:base_app/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setting_app/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorage.instance.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final appLang = AppLocalStorage.instance.get(AppConstants.appLang);
      if (appLang.isNotNullEitherEmpty) {
        ref.read(nodAppSetting.notifier).setLangCode(appLang!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final langCode = ref.watch(nodAppSetting);
    final locale = Locale(langCode);

    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppConstants.supportedLocales,
      home: const SettingPage(),
    );
  }
}
