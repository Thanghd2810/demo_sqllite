///
/// Database error definition
///
part of local_database;

class DBException implements Exception {
  int code = 0;
  String? message;
  Exception? innerException;
  StackTrace? stackTrace;

  DBException(
    this.message,
  );

  DBException.withInner(
    this.message,
    this.code,
    this.innerException,
    this.stackTrace,
  );

  @override
  String toString() {
    if (message == null) return "DBException";

    if (innerException == null) {
      return 'DBException $code: $message';
    }

    // ignore: lines_longer_than_80_chars
    return 'DBException $code: $message (Inner exception: $innerException)\n\n$stackTrace';
  }
}
