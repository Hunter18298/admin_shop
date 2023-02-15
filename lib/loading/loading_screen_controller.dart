import 'package:flutter/foundation.dart' show immutable;

//penasakrdni chand function ak loway peman ble kanjin loading be u kanjyn tawawbi
typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
