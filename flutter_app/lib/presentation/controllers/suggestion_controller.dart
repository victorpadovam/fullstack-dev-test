import 'package:flutter/material.dart';

import '../../data/models/suggestion_response_model.dart';
import '../../data/services/suggestion_service.dart';

class SuggestionController extends ChangeNotifier {
  final SuggestionService service;

  SuggestionController({SuggestionService? service})
      : service = service ?? SuggestionService();

  final TextEditingController occasionController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  SuggestionResponseModel? response;

  List<String> get suggestions => response?.suggestions ?? [];
  String get source => response?.source ?? '';

  Future<void> getSuggestions() async {
    final occasion = occasionController.text.trim();
    final relationship = relationshipController.text.trim();

    if (occasion.isEmpty || relationship.isEmpty) {
      errorMessage = 'Preencha ocasião e relacionamento.';
      response = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    response = null;
    notifyListeners();

    try {
      final result = await service.fetchSuggestions(
        occasion: occasion,
        relationship: relationship,
      );

      response = result;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      response = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void disposeControllers() {
    occasionController.dispose();
    relationshipController.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
