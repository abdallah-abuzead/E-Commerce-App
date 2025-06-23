class AppFirebaseAuthException implements Exception {
  final String code;

  AppFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'week-password':
        return 'Week password.';
      case 'user-disabled':
        return 'User account is disabled.';
      case 'user-not-found':
        return 'User not found.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'requires-recent-login':
        return 'This operation requires recent login. Please log in again.';
      case 'invalid-credential':
        return 'Invalid credential provided.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different credential. Please use that credential to log in.';
      case 'credential-already-in-use':
        return 'This credential is already in use. Please use a different credential.';
      case 'operation-not-supported':
        return 'This operation is not supported. Please contact support.';
      case 'invalid-verification-code':
        return 'Invalid verification code provided.';
      case 'invalid-verification-id':
        return 'Invalid verification ID provided.';
      case 'missing-verification-code':
        return 'Missing verification code. Please provide a valid code.';
      case 'missing-verification-id':
        return 'Missing verification ID. Please provide a valid ID.';
      case 'invalid-phone-number':
        return 'Invalid phone number provided.';
      case 'missing-phone-number':
        return 'Missing phone number. Please provide a valid phone number.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'app-not-authorized':
        return 'This app is not authorized to perform this operation. Please contact support.';
      case 'web-storage-unsupported':
        return 'Web storage is unsupported in this browser. Please try a different browser.';
      case 'invalid-continue-uri':
        return 'Invalid continue URI provided. Please check the URI and try again.';
      case 'unauthorized-continue-uri':
        return 'Unauthorized continue URI. Please check the URI and try again.';
      case 'invalid-dynamic-link-domain':
        return 'Invalid dynamic link domain provided. Please check the domain and try again.';
      case 'missing-continue-uri':
        return 'Missing continue URI. Please provide a valid URI.';
      case 'missing-tenant-id':
        return 'Missing tenant ID. Please provide a valid tenant ID.';
      case 'tenant-id-mismatch':
        return 'Tenant ID mismatch. Please ensure you are using the correct tenant ID.';
      case 'invalid-tenant-id':
        return 'Invalid tenant ID provided. Please check the ID and try again.';
      case 'invalid-email-verification-link':
        return 'Invalid email verification link provided. Please check the link and try again.';
      case 'email-already-verified':
        return 'Email is already verified.';
      case 'invalid-email-verification-request':
        return 'Invalid email verification request. Please try again.';
      case 'invalid-password-reset-link':
        return 'Invalid password reset link provided. Please check the link and try again.';
      case 'password-reset-required':
        return 'Password reset is required. Please reset your password.';
      case 'invalid-password-reset-request':
        return 'Invalid password reset request. Please try again.';
      case 'invalid-user-token':
        return 'Invalid user token provided. Please check the token and try again.';
      case 'user-token-expired':
        return 'User token has expired. Please log in again.';
      case 'user-token-revoked':
        return 'User token has been revoked. Please log in again.';
      case 'user-token-not-found':
        return 'User token not found. Please log in again.';
      case 'user-token-invalid':
        return 'User token is invalid. Please log in again.';
      case 'user-token-mismatch':
        return 'User token mismatch. Please log in again.';
      case 'user-token-unsupported':
        return 'User token is unsupported. Please log in again.';
      case 'user-token-not-allowed':
        return 'User token is not allowed. Please log in again.';
      case 'user-token-requires-recent-login':
        return 'User token requires recent login. Please log in again.';
      case 'user-token-requires-mfa':
        return 'User token requires multi-factor authentication. Please complete the MFA process.';
      case 'user-token-requires-reauthentication':
        return 'User token requires reauthentication. Please log in again.';
      case 'user-token-requires-tenant-id':
        return 'User token requires a tenant ID. Please provide a valid tenant ID.';
      case 'user-token-requires-continue-uri':
        return 'User token requires a continue URI. Please provide a valid URI.';
      case 'user-token-requires-dynamic-link-domain':
        return 'User token requires a dynamic link domain. Please provide a valid domain.';
      case 'user-token-requires-web-storage':
        return 'User token requires web storage. Please ensure your browser supports web storage.';
      case 'user-token-requires-continue-uri-authorization':
        return 'User token requires authorization for the continue URI. Please check the URI and try again.';
      case 'user-token-requires-continue-uri-unauthorized':
        return 'User token requires authorization for the continue URI, but it is unauthorized. Please check the URI and try again.';

      default:
        return 'An unknown error occurred.';
    }
  }
}
