import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/model/todo.dart';

class TodoFirebaseDatabaseInterator {
  final _todoList = List<Todo>();
  FirebaseDatabase _database = FirebaseDatabase.instance;
  final String _userId;
  StreamSubscription<Event> _todoAddedSubcription;
  StreamSubscription<Event> _todoChangedSubcription;
  TodoFirebaseDatabaseInterator(this._userId) {

    final _todoQuery = _database.reference();

    _todoAddedSubcription = _todoQuery.onChildAdded.listen((Event event) {
      DataSnapshot snapshot = event.snapshot;
      
    });

    _todoChangedSubcription = _todoQuery.onChildChanged.listen((Event event) {
      DataSnapshot snapshot = event.snapshot;
      print('change');
      print(snapshot.toString());
    });
  }

  void dispose() {
    print('dispose');
    _todoChangedSubcription.cancel();
    _todoAddedSubcription.cancel();
  }

  List<Todo> get() {
    return _todoList;
  }

  Future<Todo> post(Todo todo) {}

  Future<int> delete(String id) {}

  Future<Todo> update(Todo todo) {}

  Future<Todo> getWithId(String id) {}
}
