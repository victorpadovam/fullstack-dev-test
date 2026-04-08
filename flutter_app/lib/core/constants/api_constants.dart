class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:3345';
  static const String suggestionsEndpoint = '/api/v1/suggestions';

  static String get suggestionsUrl => '$baseUrl$suggestionsEndpoint';
}
