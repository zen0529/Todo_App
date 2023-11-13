import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_spp/todoClass.dart';
import 'package:todo_spp/todo_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(todosAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TodoService _todoService = TodoService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: _todoService.getAllTodos(),
          builder: (BuildContext context, AsyncSnapshot<List<todos>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TodoListPage();
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});
  final TodoService _todoService = TodoService();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive TODO list"),
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<todos>('todoBox').listenable(),
        builder: (context, Box<todos> box, _) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                title: Text(todo!.title),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (val) {
                    _todoService.updateIsCompleted(index, todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _todoService.deleteTodo(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Todo'),
                  content: TextField(
                    controller: _textEditingController,
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () async {
                        var todo = todos(_textEditingController.text, false);
                        await _todoService.addItem(todo);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
