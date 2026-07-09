import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ktu_dummy/main.dart';

void main() {
  testWidgets('Portal homepage smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KtuPortalApp());
    expect(find.textContaining('e-Gov Platform'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Portal profile page build test', (WidgetTester tester) async {
    await tester.pumpWidget(const KtuPortalApp());

    // Enter username & password and login
    final editableTextWidgets = find.byType(EditableText);
    await tester.enterText(editableTextWidgets.at(0), 'hi');
    await tester.enterText(editableTextWidgets.at(1), 'hi');
    
    // Tap the green login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Tap Student tab
    await tester.tap(find.text('Student'));
    await tester.pumpAndSettle();
  });
}
