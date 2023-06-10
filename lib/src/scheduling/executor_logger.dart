part of worker_manager;

class Mixinable<T> {
  late final itSelf = this as T;
}

mixin _ExecutorLogger on Mixinable<_Executor> {
  var log = false;

  static const String _debugPrefix = 'WorkerManager:';

  String get _currentTaskId;

  @mustCallSuper
  void init({int? isolatesCount}) {
    logMessage(
      "$_debugPrefix ${isolatesCount ?? numberOfProcessors} workers have been spawned and initialized",
    );
  }

  @mustCallSuper
  void execute<R>(FutureOr<R> Function() execution) {
    logMessage("$_debugPrefix added task with number $_currentTaskId");
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
