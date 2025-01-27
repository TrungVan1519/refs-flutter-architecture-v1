import 'package:base_app/core/extensions/contextx.dart';
import 'package:base_app/core/providers/nod_app_setting.dart';
import 'package:base_app/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setting_app/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(child: Text(context.lang.username)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: AppConstants.supportedLocales
            .map(
              (el) => Container(
                margin: const EdgeInsets.only(top: 16),
                child: FloatingActionButton(
                  onPressed: () {
                    ref
                        .read(nodAppSetting.notifier)
                        .setLangCode(el.languageCode);
                  },
                  tooltip: el.languageCode,
                  child: const Icon(Icons.language),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
