import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/blocs/todobloc/bloc/todobloc_bloc.dart';
import 'package:todo/models/FilteredTodos.dart';
import 'package:todo/models/todo.dart';

part 'filteredtodo_event.dart';
part 'filteredtodo_state.dart';

class FilteredtodoBloc extends Bloc<FilteredtodoEvent, FilteredtodoState> {
  TodoblocBloc todoBloc;
  StreamSubscription todoBlocStream;
  
   FilteredtodoBloc(this.todoBloc) {

    todoBlocStream = todoBloc.listen((state) {
      if (state is TodosLoaded) {
        add(TodosUpdated((todoBloc.state as TodosLoaded).todos));
      }
      
    });
    
  }

  @override
  FilteredtodoState get initialState {

    return todoBloc.state is TodosLoaded
        ? FilteredTodosLoaded(
            FilteredTodos.all, (todoBloc.state as TodosLoaded).todos)
        : FilteredtodoLoading();
  }

  @override
  Stream<FilteredtodoState> mapEventToState(
    FilteredtodoEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is TodosUpdated){
      
      yield* _mapTodosUpdatedToState(event.todos);
    }
    
  }

  Stream<FilteredtodoState> _mapTodosUpdatedToState( List<TodoItem> todos) async* {

    final filter = state is FilteredTodosLoaded ? 
                        (state as FilteredTodosLoaded).filter :
                        FilteredTodos.all;
    yield FilteredTodosLoaded(filter, _mapTodosToFilteredTodos(todos, filter));

  }

  Stream<FilteredtodoState> _mapUpdateFilterToState(
    FilterUpdated event,
  ) async* {
    if (todoBloc.state is TodosLoaded) {

      yield FilteredTodosLoaded(
        event.filter,
        _mapTodosToFilteredTodos((todoBloc.state as TodosLoaded).todos,event.filter),
      );
    }
  }

  List<TodoItem> _mapTodosToFilteredTodos(List<TodoItem> todos, FilteredTodos filter) {
    return todos.where((todo) {
      if (filter == FilteredTodos.all) {
        return true;
      } else if (filter == FilteredTodos.active) {
        return todo.isCompleted==1?false:true;
      } else {
        return todo.isCompleted==1?true:false;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    print("Closing");
    todoBlocStream.cancel();
    return super.close();
  }
}


