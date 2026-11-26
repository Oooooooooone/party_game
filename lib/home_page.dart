import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(nicknameProvider).value ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('와글와글')),
      body: Center(
        child: Text('안녕하세요, $nickname님', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
