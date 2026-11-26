import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'providers.dart';

class NicknamePage extends ConsumerStatefulWidget {
  const NicknamePage({super.key});

  @override
  ConsumerState<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends ConsumerState<NicknamePage> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool saving = false;
  String? error;

  String? check(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return '닉네임을 입력하세요';
    if (text.length < 2 || text.length > 10) return '닉네임은 2~10자로 입력하세요';
    return null;
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      saving = true;
      error = null;
    });
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'nickname': controller.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      }).timeout(const Duration(seconds: 8));
      ref.invalidate(nicknameProvider);
    } catch (e) {
      setState(() {
        error = '저장 실패: $e';
        saving = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('닉네임 입력')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  maxLength: 10,
                  decoration: const InputDecoration(labelText: '닉네임', border: OutlineInputBorder()),
                  validator: check,
                  onFieldSubmitted: (_) => save(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: saving ? null : save,
                  child: Text(saving ? '저장 중...' : '저장'),
                ),
                if (error != null) ...[
                  const SizedBox(height: 16),
                  Text(error!, style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
