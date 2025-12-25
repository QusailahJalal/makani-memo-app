// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:makani_memo_app/main.dart';

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MakaniMemoApp());

    // Verify that the app shows the main content
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
