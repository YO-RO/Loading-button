import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_button_controller.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Button',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.grey,
      ),
      home: const Scaffold(
        body: Center(child: LoginButton()),
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch<AsyncValue<Status>>(loadingButtonControllerProvider);
    final isLoading = state is AsyncLoading<Status>;
    final noButtonNeeded = state.value == Status.loggedIn;
    ref.listen<AsyncValue<Status>>(
      loadingButtonControllerProvider,
      (_, state) {
        state.whenOrNull(
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('error!')));
          },
        );
      },
    );
    return ElevatedButton(
      onPressed: isLoading || noButtonNeeded
          ? null
          : () {
              ref.read(loadingButtonControllerProvider.notifier).login();
            },
      child: isLoading
          ? const CircularProgressIndicator()
          : noButtonNeeded
              ? const Text('Logged in!')
              : const Text('login'),
    );
  }
}
