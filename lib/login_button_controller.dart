import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingButtonControllerProvider =
    StateNotifierProvider<LoadingButtonController, AsyncValue<void>>(
        (ref) => LoadingButtonController());

class LoadingButtonController extends StateNotifier<AsyncValue<void>> {
  LoadingButtonController() : super(const AsyncValue.data(null));

  Future<void> login() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 5));
    });
  }
}
