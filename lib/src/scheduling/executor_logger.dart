part of '../../worker_manager.dart';

class Mixinable<T> {
  late final itSelf = this as T;
}

mixin _ExecutorLogger on Mixinable<_Executor> {
  var log = false;
  static const String _debugPrefix = 'WorkerManager:';

  @mustCallSuper
  void init() {
    logMessage(
      "$_debugPrefix ${itSelf._isolatesCount} workers have been spawned and initialized",
    );
  }

  void logTaskAdded<R>(String uid) {
    logMessage("$_debugPrefix added task with number $uid");
  }

  @mustCallSuper
  void dispose() {
    logMessage("$_debugPrefix worker_manager have been disposed");
  }

  @mustCallSuper
  void _cancel(Task task) {
    logMessage("$_debugPrefix Task ${task.id} have been canceled");
  }

  void logMessage(String message) {
    if (log) print(message);
  }
}
