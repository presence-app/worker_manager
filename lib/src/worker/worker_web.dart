import 'dart:async';
import 'package:worker_manager/src/scheduling/task.dart';
import 'package:worker_manager/src/worker/worker.dart';

class WorkerImpl implements Worker {
  WorkerImpl();

  @override
  var initialized = false;

  @override
  String? taskId;

  void Function(Object value)? onMessage;

  @override
  Future<void> initialize() async {
    initialized = true;
  }

  @override
  Future<R> work<R>(Task<R> task) async {
    Future<R> run() async {
      return await task.execution();
    }

    taskId = task.id;
    if (task is TaskWithPort) {
      onMessage = (task as TaskWithPort).onMessage;
    }
    final resultValue = await run().whenComplete(() {
      _cleanUp();
    });
    return resultValue;
  }

  @override
  void cancelGentle() {
    _cleanUp();
  }

  @override
  void kill() {
    _cleanUp();
    initialized = false;
  }

  void _cleanUp() {
    onMessage = null;
    taskId = null;
  }

  @override
  bool get initializing => false;
}
