@JS()
library js_func;

import 'package:js/js.dart';

@JS('init')
external init(String liff_if);

@JS('getProfile')
external String getProfile();
