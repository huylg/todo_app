import 'package:flutter/cupertino.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/model/todo.dart';
import 'package:bloc/bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repo;

  TodoBloc({@required this.repo});

  @override
  TodoState get initialState => TodoUninitializeState();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    yield TodoFetchingState();

    try {
      if (event is TodoGetAllEvent) {

        final todos = await repo.get();

        yield ListTodoFetchedState(todos: todos);


      } else if (event is TodoGetEvent) {


        final id = event.id;
        final todo = await repo.getWithId(id);

        yield TodoFetchedState(todo:  todo);

      } else if (event is TodoPutEvent) {

      } else if (event is TodoDeleteEvent) {

      } else if (event is TodoPostEvent) {

      }
    } catch (e) {}
  }
}
