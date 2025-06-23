class AppPlatformException implements Exception {
  final String code;

  AppPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'Network error occurred. Please check your connection.';
      case 'user_not_found':
        return 'User not found. Please check your credentials.';
      case 'invalid_credentials':
        return 'Invalid credentials provided.';
      case 'unknown_error':
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
