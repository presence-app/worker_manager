import 'dart:async';

import 'package:uuid/uuid.dart';

class Task<O> {
  final Function function;
  final Object bundle;
  final Duration timeout;
  final completer = Completer<O>();
  String id = Uuid().v4();

  Task({this.function, this.bundle, this.timeout});
}
