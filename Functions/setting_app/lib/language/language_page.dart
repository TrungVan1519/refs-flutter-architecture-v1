import 'package:base_app/core/extensions/contextx.dart';
import 'package:base_app/core/providers/nod_app_setting.dart';
import 'package:base_app/core/utils/app_constants.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = ref.watch(nodAppSetting);

    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: AppConstants.supportedLocales.length,
          itemBuilder: (context, index) {
            final el = AppConstants.supportedLocales[index];

            return Card(
              child: ListTile(
                onTap: () {
                  ref.read(nodAppSetting.notifier).setLangCode(el.languageCode);
                  if (context.mounted) context.back();
                },
                title: Text(el.languageCode.toUpperCase()),
                leading: CountryFlag.fromLanguageCode(
                  el.languageCode,
                  shape: const Circle(),
                ),
                trailing: langCode == el.languageCode
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
