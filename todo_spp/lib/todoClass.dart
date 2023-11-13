// ignore_for_file: camel_case_types

import 'package:hive/hive.dart';
part 'todoClass.g.dart';

@HiveType(typeId: 1)
class todos {
  @HiveField(0)
  final String title;

  @HiveField(1, defaultValue: false)
  bool isCompleted;

  todos(this.title, this.isCompleted);
}
