class AppFirebaseException implements Exception {
  final String code;

  AppFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'Service is currently unavailable. Please try again later.';
      default:
        return 'An unknown error occurred: $code';
    }
  }
}
