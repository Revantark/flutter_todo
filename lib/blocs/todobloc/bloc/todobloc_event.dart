part of 'todobloc_bloc.dart';

abstract class TodoblocEvent extends Equatable {
  const TodoblocEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends TodoblocEvent {}



class AddTodo extends TodoblocEvent {
  final TodoItem item;
  const AddTodo({this.item});
  @override
  List<Object> get props => [item];

}

class RefreshTodos extends TodoblocEvent {
 

  @override
  List<Object> get props => [];

}

class DeleteTodo extends TodoblocEvent {
  final String title;
  final int index;
  const DeleteTodo({this.title,this.index});
  @override
  List<Object> get props => [title,index];

}

class UpdateTodo extends TodoblocEvent {
  final TodoItem item;
  final String title;
  final int index;
  const UpdateTodo({this.item,this.title,this.index});
  @override
  List<Object> get props => [item,title,index];

}