part of utils;

/// [Debouncer] is used to prevent repeated calls to a method
/// ///
/// use it:
/// ```
///   final _debouncer = Debouncer(milliseconds: 300);
///
//  _debouncer.run(() {
//    Navigator.of(context).pop();
//  });
/// ```
///
class Debouncer {
  final int? milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }

  void dispose() => _timer?.cancel();
}
