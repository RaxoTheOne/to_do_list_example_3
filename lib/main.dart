import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TodoListItem extends StatefulWidget {
  final String title;
  final ValueChanged<bool> onCheckboxChanged;

  TodoListItem({required this.title, required this.onCheckboxChanged});

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            decoration: _isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
      trailing: Checkbox(
        value: _isChecked,
        onChanged: (bool? value) {
          setState(() {
            _isChecked = value!;
            widget.onCheckboxChanged(value);
          });
        },
      ),
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onCheckboxChanged(_isChecked);
        });
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
        ),
        body: Center(
          child: TodoList(),
        ),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = ['Task 1', 'Task 2', 'Task 3'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoListItem(
          title: todos[index],
          onCheckboxChanged: (bool value) {
            setState(() {
              // Aktualisiere den Status des To-Do-Eintrags im State
              todos[index] =
                  value ? 'Task ${index + 1} erledigt' : 'Task ${index + 1}';
            });
          },
        );
      },
    );
  }
}
