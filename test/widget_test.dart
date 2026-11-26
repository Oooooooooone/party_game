import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_game/login_page.dart';
import 'package:party_game/nickname_page.dart';

void main() {
  testWidgets('로그인 화면에 시작하기 버튼이 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('시작하기'), findsOneWidget);
  });

  testWidgets('닉네임이 공백이거나 1자면 에러가 나온다', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: NicknamePage())));

    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.tap(find.text('저장'));
    await tester.pump();
    expect(find.text('닉네임을 입력하세요'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '가');
    await tester.tap(find.text('저장'));
    await tester.pump();
    expect(find.text('닉네임은 2~10자로 입력하세요'), findsOneWidget);
  });
}
