import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../models/suggestion_response_model.dart';

class SuggestionService {
  final http.Client client;

  SuggestionService({http.Client? client}) : client = client ?? http.Client();

  Future<SuggestionResponseModel> fetchSuggestions({
    required String occasion,
    required String relationship,
  }) async {
    final uri = Uri.parse(ApiConstants.suggestionsUrl);

    try {
      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'occasion': occasion,
          'relationship': relationship,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return SuggestionResponseModel.fromJson(data);
      }

      String errorMessage = 'Erro ao buscar sugestões.';

      try {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        if (errorData['message'] != null) {
          errorMessage = errorData['message'];
        }
      } catch (_) {}

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(
        'Não foi possível conectar ao servidor. Verifique se o backend está rodando.',
      );
    }
  }
}
