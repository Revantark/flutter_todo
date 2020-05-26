import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class EditTodo extends StatefulWidget {
  final TodoItem todo;
  EditTodo({this.todo});
  @override
  _EditTodoState createState() => _EditTodoState(todo: todo);
}

class _EditTodoState extends State<EditTodo> {
  final title = TextEditingController();
  final content = TextEditingController();
  final TodoItem todo;
  _EditTodoState({this.todo});

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      title.text = todo.title;
      content.text = todo.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: title,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24))),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: content,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: "Content (optional)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24))),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (title.text.length == 0) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: const Text("Please fill the title")));
          } else if (title.text.length < 4) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content:
                    const Text("Title must atleast contain 4 characters")));
          } else {
            TodoItem todo = TodoItem(
                content: content.text, title: title.text, isCompleted: 0);
            Navigator.pop(context, [todo]);
          }
        },
      ),
    );
  }
}
