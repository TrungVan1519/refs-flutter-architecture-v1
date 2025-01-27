import 'package:base_app/core/extensions/contextx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setting_app/avatar/providers/nod_avatar.dart';

class AvatarPage extends ConsumerStatefulWidget {
  const AvatarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarPageState();
}

class _AvatarPageState extends ConsumerState<AvatarPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(nodAvatarList.notifier).getAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(nodAvatarList);
    final avatar = ref.watch(podSetAvatar);

    return Scaffold(
        body: switch (res.status) {
      AvatarLoadingState.loading =>
        const Center(child: CircularProgressIndicator()),
      AvatarLoadingState.fail =>
        const Center(child: Text('Error when get avatar list')),
      AvatarLoadingState.success => res.data.isEmpty
          ? const Center(child: Text('No available avatar'))
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: res.data.length,
              itemBuilder: (context, index) {
                final el = res.data[index];

                return Card(
                  child: ListTile(
                    onTap: () {
                      ref.read(podSetAvatar.notifier).update((state) => el);
                      if (context.mounted) context.back();
                    },
                    title: Text(el),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(el),
                    ),
                    trailing: avatar == el
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                );
              },
            ),
      _ => const SizedBox(),
    });
  }
}
