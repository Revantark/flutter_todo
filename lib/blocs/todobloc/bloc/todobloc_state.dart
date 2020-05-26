part of 'todobloc_bloc.dart';

abstract class TodoblocState extends Equatable {
  const TodoblocState();
}

class TodoLoading extends TodoblocState {
  @override
  List<Object> get props => [];
}

class TodosLoaded extends TodoblocState {
  final List<TodoItem> todos ;
  const TodosLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodosLoadingFailed extends TodoblocState {
  @override
  List<Object> get props => [];
}