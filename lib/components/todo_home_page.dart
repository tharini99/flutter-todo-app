import 'package:flutter/material.dart';

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<String> _todos = [];
  final Set<String> _completedTodos = {};

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todos[index]);
      },
    );
  }

  Widget _buildTodoItem(String todo) {
    return CheckboxListTile(
      title: Text(todo),
      value: _completedTodos.contains(todo),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            _completedTodos.add(todo);
          } else {
            _completedTodos.remove(todo);
          }
        });
      },
      secondary: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteTodoItem(todo),
      ),
    );
  }

  void _addTodoItem(String task) {
    setState(() {
      _todos.add(task);
    });
  }

  void _deleteTodoItem(String task) {
    setState(() {
      _todos.remove(task);
    });
  }

  Future<void> _displayAddTodoDialog(BuildContext context) async {
    String newTodo = '';
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a new task'),
          content: TextField(
            onChanged: (value) {
              newTodo = value;
            },
            decoration: InputDecoration(hintText: "Enter task here"),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (newTodo.isNotEmpty) {
                  _addTodoItem(newTodo);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My To-Do List')),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddTodoDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
