import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:party_game/login_page.dart';

void main() {
  testWidgets('로그인 화면에 시작하기 버튼이 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('시작하기'), findsOneWidget);
  });
}
