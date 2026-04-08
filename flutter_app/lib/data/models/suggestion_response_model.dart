class SuggestionResponseModel {
  final List<String> suggestions;
  final String source;

  SuggestionResponseModel({
    required this.suggestions,
    required this.source,
  });

  factory SuggestionResponseModel.fromJson(Map<String, dynamic> json) {
    return SuggestionResponseModel(
      suggestions: List<String>.from(json['suggestions'] ?? []),
      source: json['source'] ?? '',
    );
  }
}
