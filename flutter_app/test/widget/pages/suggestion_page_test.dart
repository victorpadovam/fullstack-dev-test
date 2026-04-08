import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/presentation/controllers/suggestion_controller.dart';
import 'package:flutter_app/presentation/pages/suggestion_page.dart';

import '../../mock/mock_suggestion_service.dart';

void main() {
  late MockSuggestionService mockService;
  late SuggestionController controller;

  setUp(() {
    mockService = MockSuggestionService();
    controller = SuggestionController(service: mockService);
  });

  tearDown(() {
    controller.dispose();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: SuggestionPage(controller: controller),
    );
  }

  testWidgets('deve renderizar os elementos principais da tela',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Gift Card Message Suggester'), findsOneWidget);
    expect(find.text('Ocasião'), findsOneWidget);
    expect(find.text('Relação'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('deve mostrar erro ao clicar sem preencher os campos',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Preencha ocasião e relacionamento.'), findsOneWidget);
  });
}
