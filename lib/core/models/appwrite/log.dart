/// A data model for holding log entries.
class Log {
  final String date;
  final int status;
  final String method;
  final String path;
  final String response;

  Log({
    required this.date,
    required this.status,
    required this.method,
    required this.path,
    required this.response,
  });
}