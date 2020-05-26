import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/data_provider/user_repository.dart';
import 'package:todo/models/todo.dart';

part 'todobloc_event.dart';
part 'todobloc_state.dart';

class TodoblocBloc extends Bloc<TodoblocEvent, TodoblocState> {
  final UserRepository userRepository;
  TodoblocBloc({this.userRepository});

  @override
  TodoblocState get initialState => TodoLoading();

  @override
  Stream<TodoblocState> mapEventToState(
    TodoblocEvent event,
  ) async* {
    if (event is AppStarted) {
      try {
        await userRepository.init();
        final todos = await userRepository.getTodos();
        yield TodosLoaded(todos);
      } catch (_) {
        yield TodosLoadingFailed();
      }
    } else if (event is AddTodo) {
      yield* _mapAddToState(event.item);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateToState(event.item, event.title, event.index);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteToState(event.title, event.index);
    } else if (event is RefreshTodos) {
      try {
        final todos = await userRepository.getTodos();
        yield TodosLoaded(todos);
      } catch (_) {
        yield TodosLoadingFailed();
      }

    }
  }



  Stream<TodoblocState> _mapAddToState(TodoItem item) async* {
    final List<TodoItem> todos = List.from((state as TodosLoaded).todos)
      ..add(item);

    yield TodosLoaded(todos);

    userRepository.insertTodo(item);
    //check
  }

  Stream<TodoblocState> _mapUpdateToState(
      TodoItem item, String title, int index) async* {
    
    
    List<TodoItem> todos = List.from((state as TodosLoaded).todos);
    // todos.insert(index, item); //check
    // todos.removeAt(index + 1);
    yield  TodoLoading();
    todos.elementAt(index).content = item.content;
    todos.elementAt(index).title = item.title;
    todos.elementAt(index).isCompleted = item.isCompleted;
    yield TodosLoaded(todos);
    userRepository.updateTodo(item, title);
  }

  Stream<TodoblocState> _mapDeleteToState(String title, int index) async* {
    List<TodoItem> todos = List.from((state as TodosLoaded).todos);
    todos.removeAt(index);
    yield TodosLoaded(todos);
    userRepository.deleteTodo(title); //check
  }
}
