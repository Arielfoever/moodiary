import 'dart:async';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:moodiary/api/api.dart';
import 'package:moodiary/utils/cache_util.dart';
import 'package:refreshed/refreshed.dart';

class WindowButtons extends StatelessWidget {
  final RxString hitokoto = ''.obs;

  //获取一言
  Future<void> getHitokoto() async {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      final res = await CacheUtil.getCacheList('hitokoto', Api.updateHitokoto,
          maxAgeMillis: 15 * 60000);
      if (res != null) {
        hitokoto.value = res.first;
      }
    }
  }

  WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    //unawaited(getHitokoto());
    final colorScheme = Theme.of(context).colorScheme;
    final buttonColors = WindowButtonColors(
      iconNormal: colorScheme.secondary,
      mouseDown: colorScheme.secondaryContainer,
      normal: colorScheme.surfaceContainer,
      iconMouseDown: colorScheme.secondary,
      mouseOver: colorScheme.secondaryContainer,
      iconMouseOver: colorScheme.onSecondaryContainer,
    );

    final closeButtonColors = WindowButtonColors(
      iconNormal: colorScheme.secondary,
      mouseDown: colorScheme.secondaryContainer,
      normal: colorScheme.surfaceContainer,
      iconMouseDown: colorScheme.secondary,
      mouseOver: colorScheme.errorContainer,
      iconMouseOver: colorScheme.onErrorContainer,
    );
    return WindowTitleBarBox(
      child: MoveWindow(
        child: Container(
          color: colorScheme.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MinimizeWindowButton(colors: buttonColors),
              MaximizeWindowButton(colors: buttonColors),
              CloseWindowButton(colors: closeButtonColors),
            ],
          ),
        ),
      ),
    );
  }
}
