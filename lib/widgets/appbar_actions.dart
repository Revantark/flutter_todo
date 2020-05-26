import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/filteredTodo/bloc/filteredtodo_bloc.dart';
import 'package:todo/models/FilteredTodos.dart';

class AppBarActions extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
            icon: Icon(Icons.filter_list),
            onSelected: (value) {
              if (value == 0) {
                BlocProvider.of<FilteredtodoBloc>(context)
                    .add(FilterUpdated(filter: FilteredTodos.all));
              } else if (value == 2) {
                BlocProvider.of<FilteredtodoBloc>(context)
                    .add(FilterUpdated(filter: FilteredTodos.completed));
              } else {
                BlocProvider.of<FilteredtodoBloc>(context)
                    .add(FilterUpdated(filter: FilteredTodos.active));
              }
            },
            itemBuilder: (context) {
              final filter = (BlocProvider.of<FilteredtodoBloc>(context).state as FilteredTodosLoaded).filter;
              return List.generate(3, (index) {
                return PopupMenuItem(
                  child: Text("Show"+(index==0?"All":(index==1?"Active":"Completed"))),
                  value: index,
                  textStyle: TextStyle(
                    color: filter.index==index?Colors.red[300]:Colors.white
                  ),
                );
              });
            },
          );
  }
}