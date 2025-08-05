/// Class represents the environment values for the mobile app.
class Env {
  /// Represents the encryption key used for preferences.
  static const preferencesEncryptionKey = String.fromEnvironment(
    'PREFERENCES_ENCRYPTION_KEY',
  );

  /// Represents the initialization vector (IV) used for preferences encryption.
  static const preferencesInitializationVectorBase64 = String.fromEnvironment(
    'PREFERENCES_INITIALIZATION_VECTOR_BASE64',
  );

  /// Represents the base URL for the global API.
  static const globalAPIBaseURL = String.fromEnvironment('GLOBAL_API_BASE_URL');

  /// Represents the flavor of the application.
  static const flavor = String.fromEnvironment('FLAVOR');

  /// Represents a banner for the application.
  static const banner = String.fromEnvironment('BANNER');

  /// Initialize the Env Class
  static void initialize() {
    /// Every environment values should have it's own exception handler
    if (Env.preferencesEncryptionKey.isEmpty) {
      throw Exception('PREFERENCES_ENCRYPTION_KEY not defined');
    }

    if (Env.preferencesInitializationVectorBase64.isEmpty) {
      throw Exception('PREFRENCES_INITIALIZATION_VECTOR_BASE64 not defined');
    }

    if (Env.globalAPIBaseURL.isEmpty) {
      throw Exception('GLOBAL_API_BASE_URL not defined');
    }

    if (Env.flavor.isEmpty) {
      throw Exception('FLAVOR not defined');
    }

    if (Env.banner.isEmpty && Env.flavor != 'prod') {
      throw Exception('BANNER not defined');
    }
  }
}
