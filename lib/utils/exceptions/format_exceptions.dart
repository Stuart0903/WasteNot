/// Custom exception class to handle various format-related errors.
class WNFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const WNFormatException(
      [this.message = "An unexpected format error occurred. Please check your input."]);

  /// Create a format exception from a specific error message.
  factory WNFormatException.fromMessage(String message) {
    return WNFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory WNFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const WNFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const WNFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const WNFormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const WNFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const WNFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const WNFormatException('The input should be a valid numeric format.');
      default:
        return const WNFormatException(); // Ensures the factory always returns an instance
    }
  }

  @override
  String toString() => 'WNFormatException: $message';
}
