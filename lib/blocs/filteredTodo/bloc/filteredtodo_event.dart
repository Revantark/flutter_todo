part of 'filteredtodo_bloc.dart';

abstract class FilteredtodoEvent extends Equatable {
  const FilteredtodoEvent();
}

class FilterUpdated extends FilteredtodoEvent {
  final FilteredTodos filter;
  const FilterUpdated({this.filter});

  @override
  List<Object> get props => [filter];
}

class TodosUpdated extends FilteredtodoEvent {
  final List<TodoItem> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];
  
}