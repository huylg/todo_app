import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/todo.dart';

abstract class TodoEvent {}

class TodoPostEvent extends TodoEvent {
  final Todo todo;
  TodoPostEvent({@required this.todo});
}

class TodoDeleteEvent extends TodoEvent {
  final String id;
  TodoDeleteEvent({@required this.id});
}

class TodoPutEvent extends TodoEvent {
  final Todo todo;
  TodoPutEvent({@required this.todo});
}

class TodoGetEvent extends TodoEvent {
  final String id;
  TodoGetEvent({@required this.id});
}

class TodoGetAllEvent extends TodoEvent {}
