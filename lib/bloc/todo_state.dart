import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/todo.dart';

abstract class TodoState {}

class TodoUninitializeState extends TodoState {}

class ListTodoFetchedState extends TodoState {
  final List<Todo> todos;
  ListTodoFetchedState({@required this.todos});
}


class TodoFetchedState extends TodoState {
  final Todo todo;
  TodoFetchedState({@required this.todo});
}

class TodoFetchedNonDataState extends TodoState{}

class TodoFetchingState extends TodoState {}

class TodoErrorState extends TodoState {}
