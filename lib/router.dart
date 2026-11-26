import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'nickname_page.dart';
import 'providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier(0);
  ref.listen(authProvider, (prev, next) => refresh.value++);
  ref.listen(nicknameProvider, (prev, next) => refresh.value++);

  return GoRouter(
    initialLocation: '/loading',
    refreshListenable: refresh,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final auth = ref.read(authProvider);
      if (auth.isLoading) return loc == '/loading' ? null : '/loading';

      final user = auth.value;
      if (user == null) return loc == '/login' ? null : '/login';

      final nick = ref.read(nicknameProvider);
      if (nick.isLoading) return loc == '/loading' ? null : '/loading';

      if (nick.value == null) return loc == '/nickname' ? null : '/nickname';

      return loc == '/home' ? null : '/home';
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/nickname', builder: (context, state) => const NicknamePage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
});
