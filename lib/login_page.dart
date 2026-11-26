import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? uid;
  String? error;
  bool loading = false;

  Future<void> login() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final result = await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        uid = result.user?.uid;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('와글와글')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('와글와글', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              if (uid == null)
                ElevatedButton(
                  onPressed: loading ? null : login,
                  child: Text(loading ? '로그인 중...' : '시작하기'),
                ),
              if (uid != null) Text('로그인 성공!\n내 아이디: $uid', textAlign: TextAlign.center),
              if (error != null) ...[
                const SizedBox(height: 16),
                Text(error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
