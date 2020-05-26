import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/filteredTodo/bloc/filteredtodo_bloc.dart';
import 'package:todo/blocs/todobloc/bloc/todobloc_bloc.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/edit_todo.dart';
import 'package:todo/widgets/page_route.dart';
import 'leave_behind_hint.dart';

class TodoList extends StatelessWidget {
  final GlobalKey<AnimatedListState> _todoListKey;
  TodoList(this._todoListKey);

  @override
  Widget build(BuildContext context) {
    List<TodoItem> todos = List.from((BlocProvider.of<FilteredtodoBloc>(context)
            .state as FilteredTodosLoaded)
        .todos);
    return StatefulBuilder(builder: (context, setState) {
      bool removeTodo = false;
      return AnimatedList(
        key: _todoListKey,
        initialItemCount: todos.length,
        itemBuilder: (context, index, animation) {
          return Dismissible(
            key: Key(todos[index].title),
            background: const DeleteHint(),
            onDismissed: (direction) async {
              final todo = todos.elementAt(index);
              _todoListKey.currentState
                  .removeItem(index, (context, animation) => SizedBox());
              removeTodo = true;
              todos.removeAt(index);
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context)
                  .showSnackBar(SnackBar(
                    content: Text("Deleted"),
                    duration: Duration(milliseconds: 2500),
                    action: SnackBarAction(
                        label: "undo",
                        onPressed: () async {
                          removeTodo = false;
                          _todoListKey.currentState.insertItem(index);
                          todos.insert(index, todo);
                        }),
                  ))
                  .closed
                  .then((value) {
                if (removeTodo)
                  BlocProvider.of<TodoblocBloc>(context)
                      .add(DeleteTodo(title: todo.title, index: index));
                removeTodo = false;
              });
            },
            child: SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    SizeRoute(page: EditTodo(todo: todos[index])),
                  ) as List<TodoItem>;

                  if (result != null) {
                    todos[index].copy(result[0]);
                    BlocProvider.of<TodoblocBloc>(context).add(UpdateTodo(
                        title: todos[index].title,
                        index: index,
                        item: result[0]));
                  }
                },
                leading: Checkbox(
                    value: todos[index].isCompleted == 0 ? false : true,
                    onChanged: (val) {
                      if (val) {
                        TodoItem todo = todos.elementAt(index);
                        todo.todoCompleted();
                        todos[index].isCompleted = 1;
                        setState(() {});
                        BlocProvider.of<TodoblocBloc>(context).add(UpdateTodo(
                            title: todos[index].title,
                            index: index,
                            item: todo));
                      } else {
                        TodoItem todo = todos.elementAt(index);
                        todo.isCompleted = 0;
                        todos[index].isCompleted = 0;
                        setState(() {});

                        BlocProvider.of<TodoblocBloc>(context).add(UpdateTodo(
                            title: todos[index].title,
                            index: index,
                            item: todo));
                      }
                    }),
                title: Text(todos[index].title),
                subtitle:todos[index].content.isNotEmpty?Text(todos[index].content):"...",
              ),
            ),
          );
        },
      );
    });
  }
}
