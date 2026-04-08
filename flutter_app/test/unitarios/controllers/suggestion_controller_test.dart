import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_app/data/models/suggestion_response_model.dart';
import 'package:flutter_app/presentation/controllers/suggestion_controller.dart';

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

  group('SuggestionController', () {
    test('deve exibir erro se ocasião ou relacionamento estiver vazio',
        () async {
      controller.occasionController.text = '';
      controller.relationshipController.text = '';

      await controller.getSuggestions();

      expect(controller.errorMessage, 'Preencha ocasião e relacionamento.');
      expect(controller.isLoading, false);
      expect(controller.suggestions, isEmpty);
    });

    test('deve carregar sugestões com sucesso', () async {
      final mockResponse = SuggestionResponseModel(
        suggestions: [
          'Feliz aniversário, meu amigo!',
          'Parabéns pelo seu dia!',
          'Muitas felicidades neste aniversário!',
        ],
        source: 'llm',
      );

      when(
        () => mockService.fetchSuggestions(
          occasion: 'aniversário',
          relationship: 'amigo',
        ),
      ).thenAnswer((_) async => mockResponse);

      controller.occasionController.text = 'aniversário';
      controller.relationshipController.text = 'amigo';

      await controller.getSuggestions();

      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
      expect(controller.suggestions.length, 3);
      expect(controller.source, 'llm');
      expect(controller.suggestions.first, 'Feliz aniversário, meu amigo!');
    });

    test('deve exibir erro quando o service falhar', () async {
      when(
        () => mockService.fetchSuggestions(
          occasion: 'aniversário',
          relationship: 'amigo',
        ),
      ).thenThrow(Exception('Erro ao buscar sugestões'));

      controller.occasionController.text = 'aniversário';
      controller.relationshipController.text = 'amigo';

      await controller.getSuggestions();

      expect(controller.isLoading, false);
      expect(controller.errorMessage, 'Erro ao buscar sugestões');
      expect(controller.suggestions, isEmpty);
    });
  });
}
