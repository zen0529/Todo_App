// ignore_for_file: camel_case_types

import 'package:hive/hive.dart';
import 'package:todo_spp/todoClass.dart';

class TodoService {
  final String _boxName = "todoBox";

  Future<Box<todos>> get _box async => await Hive.openBox<todos>(_boxName);

  Future<void> addItem(todos todoItem) async {
    var box = await _box;

    await box.add(todoItem);
  }

  Future<List<todos>> getAllTodos() async {
    var box = await _box;

    return box.values.toList();
  }

  Future<void> deleteTodo(int index) async {
    var box = await _box;

    await box.deleteAt(index);
  }

  Future<void> updateIsCompleted(int index, todos todo) async {
    var box = await _box;

    todo.isCompleted = !todo.isCompleted;
    await box.putAt(index, todo);
  }
}
