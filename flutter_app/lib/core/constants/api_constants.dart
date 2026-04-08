class ApiConstants {
  static const String baseUrl =
      'https://9dc4-2804-14d-1884-4e87-b122-ef5e-92bf-a31b.ngrok-free.app';
  static const String suggestionsEndpoint = '/api/v1/suggestions';

  static String get suggestionsUrl => '$baseUrl$suggestionsEndpoint';
}
