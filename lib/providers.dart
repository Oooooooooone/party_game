import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final nicknameProvider = FutureProvider<String?>((ref) async {
  final user = ref.watch(authProvider).value;
  if (user == null) return null;
  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .timeout(const Duration(seconds: 8));
    return doc.data()?['nickname'];
  } catch (e) {
    return null;
  }
});
