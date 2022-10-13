@JS()
library liff_func;

import 'package:js/js.dart';

// jsファイルから関数呼出し
@JS('liffInit')
external Object liffInit(String liffId);

@JS('liffGetProfile')
external Object liffGetProfile();
