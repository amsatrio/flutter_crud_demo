class Environment {
  static const String apiKey = String.fromEnvironment('API_KEY');
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const bool debugEnabled = bool.fromEnvironment('DEBUG_ENABLED', defaultValue: true);
  static const bool darkThemeEnabled = bool.fromEnvironment('DARK_THEME_ENABLED', defaultValue: false);
}