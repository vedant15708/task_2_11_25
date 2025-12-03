import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/utils/app_snackbar.dart';
import '../../core/utils/app_toast.dart';
import '../../viewmodel/todo_store.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoStore store = TodoStore();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String msg = await store.loadTodos();

    if (!mounted) return;

    if (msg == "Todos loaded sucessfully") {
      Snackbar.success(context, msg);
    } else {
      AppToast.show(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,title: const Text("Todo List",style: TextStyle(color: Colors.white),),centerTitle: true,),

      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ---- FIX: Your store contains List<TodoModel> ----
          // We must extract the inner todos list
          final allTodos = store.todos.isNotEmpty
              ? store.todos[0].todos ?? []
              : [];

          return ListView.builder(
            itemCount: allTodos.length,
            itemBuilder: (context, index) {
              final todo = allTodos[index];

              return ListTile(
                leading: Checkbox(
                  value: todo.completed ?? false,
                  onChanged: null,
                ),
                title: Text(todo.todo ?? ""),
              );
            },
          );
        },
      ),
    );
  }
}
