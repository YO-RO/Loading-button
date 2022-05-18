import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingButtonControllerProvider =
    StateNotifierProvider<LoadingButtonController, AsyncValue<Status>>(
        (ref) => LoadingButtonController());

enum Status {
  loggedOut,
  loggedIn,
}

class LoadingButtonController extends StateNotifier<AsyncValue<Status>> {
  LoadingButtonController() : super(const AsyncValue.data(Status.loggedOut));

  Future<void> login() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));
      return Status.loggedIn;
    });
  }
}
