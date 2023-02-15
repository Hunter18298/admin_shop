import 'package:flutter/foundation.dart';

///zyadrkrdi extension lo away hamujar email u password y daxilnakayn ka damanawe
///application akay taqikaynawa ba bakarheneani kDebugMode
///law extension a bas esh lasar string y dakain
///aw extension a la page y login + register y bakarhatya
extension IFDebugging on String {
  String? get ifDebugging => kDebugMode ? this : null;
}
