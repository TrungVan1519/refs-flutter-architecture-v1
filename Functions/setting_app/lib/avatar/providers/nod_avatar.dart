import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AvatarLoadingState { init, loading, success, fail }

class AvatarListNotifier
    extends StateNotifier<({AvatarLoadingState status, List<String> data})> {
  AvatarListNotifier() : super((status: AvatarLoadingState.init, data: []));

  void getAssets() async {
    try {
      state = (status: AvatarLoadingState.loading, data: []);
      await Future.delayed(Durations.extralong4);

      // todo list all assets
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final manifestMap = jsonDecode(manifestContent);

      // todo filter assets by the given path
      final assets = manifestMap.keys
          .where((String key) => key.startsWith('packages/setting_app/assets/'))
          .toList();

      state = (status: AvatarLoadingState.success, data: assets);
    } catch (e) {
      state = (status: AvatarLoadingState.fail, data: []);
    }
  }
}

final nodAvatarList = StateNotifierProvider<AvatarListNotifier,
    ({AvatarLoadingState status, List<String> data})>((ref) {
  return AvatarListNotifier();
});

final podSetAvatar = StateProvider<String>((ref) {
  final res = ref.read(nodAvatarList);
  return res.data.isEmpty ? '' : res.data.first;
});
