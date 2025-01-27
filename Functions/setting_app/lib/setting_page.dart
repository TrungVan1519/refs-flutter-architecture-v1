import 'package:base_app/core/extensions/contextx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setting_app/avatar/avatar_page.dart';
import 'package:setting_app/avatar/providers/nod_avatar.dart';
import 'package:setting_app/language/language_page.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatar = ref.watch(podSetAvatar);

    return Scaffold(
      appBar: AppBar(title: Text(context.lang.settings)),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                    context.showRoundedModalBottomSheet((context) {
                      return const AvatarPage();
                    });
                  },
                  title: Text(context.lang.avatar),
                  trailing: avatar.isEmpty
                      ? null
                      : Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(avatar),
                        ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  onTap: () {
                    context.showRoundedModalBottomSheet((context) {
                      return const LanguagePage();
                    });
                  },
                  title: Text(context.lang.languages),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
