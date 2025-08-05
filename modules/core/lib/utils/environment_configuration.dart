/// Class represents the environment values for the mobile app.
class Env {
  /// Represents the base URL for the global API.
  static const globalAPIBaseURL = String.fromEnvironment('API_BASE_URL');

  /// Represents the flavor of the application.
  static const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');

  /// Represents a banner for the application.
  static const banner = String.fromEnvironment('BANNER');

  /// Initialize the Env Class
  static void initialize() {
    if (Env.globalAPIBaseURL.isEmpty) {
      throw Exception('API_BASE_URL not defined');
    }
  }
}
