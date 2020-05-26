part of 'filteredtodo_bloc.dart';

abstract class FilteredtodoState extends Equatable {
  const FilteredtodoState();
}

class FilteredtodoLoading extends FilteredtodoState {
  @override
  List<Object> get props => [];
}

class FilteredTodosLoaded extends FilteredtodoState {
  final FilteredTodos filter;
  final List<TodoItem> todos;

  const FilteredTodosLoaded(this.filter,this.todos);

  @override
  List<Object> get props => [filter,todos];


}