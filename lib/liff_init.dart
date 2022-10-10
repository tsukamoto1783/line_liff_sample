@JS()
library js_func;

import 'package:js/js.dart';

@JS('init')
external Object init(String liffId);

@JS('getProfile')
external Object getProfile();
