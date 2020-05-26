import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/filteredTodo/bloc/filteredtodo_bloc.dart';
import 'package:todo/blocs/todobloc/bloc/todobloc_bloc.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/edit_todo.dart';
import 'package:todo/widgets/TodoList.dart';
import 'package:todo/widgets/appbar_actions.dart';
import 'package:todo/widgets/page_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final listKey = GlobalKey<AnimatedListState>();
  List<TodoItem> todos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo",
          style: TextStyle(color: Colors.white),
        ),
        //centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: BlocBuilder<FilteredtodoBloc, FilteredtodoState>(
        builder: (context, state) {
          if (state is FilteredtodoLoading) {
            return Padding(
              padding: const EdgeInsets.all(150.0),
              child: const Center(
                child: LinearProgressIndicator(),
              ),
            );
          } else if (state is FilteredTodosLoaded) {
            return state.todos.isNotEmpty
                ? TodoList(listKey)
                : const Center(child: Text("No Todos, Add One"));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final r = await Navigator.push(context, SizeRoute(page: EditTodo()))
              as List<TodoItem>;
          if (r != null) {
            
            if (listKey.currentState != null){
              listKey.currentState.insertItem(
                (BlocProvider.of<FilteredtodoBloc>(context).state as FilteredTodosLoaded).todos.length
              );
            }
            BlocProvider.of<TodoblocBloc>(context).add(AddTodo(item: r[0]));
          }
        },
      ),
    );
  }

  
}
