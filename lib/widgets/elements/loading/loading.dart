import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../route/router.dart';
import 'indicator.dart';

final loadingStateProvider = StateNotifierProvider<_LoadingState, bool>(
  (ref) => _LoadingState(),
);

class _LoadingState extends StateNotifier<bool> {
  _LoadingState() : super(false);

  Future<void> whileLoading(Future Function() future) {
    return Future.microtask(show).then((_) => future()).whenComplete(hide);
  }

  Future<void> whileLoading2(Future Function() future) {
    return Future.microtask(show).then((_) => future()).whenComplete(hide);
  }

  void show() {
    if (state) return;
    state = true;
    _showLoading();
  }

  void hide() {
    if (!state) return;
    state = false;
    _hideLoading();
  }
}

Future<void> _showLoading() {
  return showDialog(
    barrierDismissible: false,
    context: useContext(),
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Center(
          child: Indicator(radius: 14.0, color: IndicatorColor.white),
        ),
      );
    },
  );
}

void _hideLoading() {
  AppRouter().pop();
}
