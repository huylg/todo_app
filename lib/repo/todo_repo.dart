import 'package:todo_app/network/firebase_database_interactor.dart';
import 'package:todo_app/model/todo.dart';

class TodoRepository {
  final _todoList = List<Todo>();
  TodoFirebaseDatabaseInterator _firebaseDataseInteractor;
  final String _userId;

  TodoRepository(this._userId) {
    _firebaseDataseInteractor = TodoFirebaseDatabaseInterator(_userId);
  }

  Future<List<Todo>> get() async => _firebaseDataseInteractor.get();
  Future<Todo> post(Todo todo) async => _firebaseDataseInteractor.post(todo);
  Future<int> delete(String id) async => _firebaseDataseInteractor.delete(id);
  Future<Todo> update(Todo todo) async =>
      _firebaseDataseInteractor.update(todo);
  Future<Todo> getWithId(String id) async =>
      _firebaseDataseInteractor.getWithId(id);
}
