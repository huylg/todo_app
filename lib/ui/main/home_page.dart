import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/network/firebase_auth.dart';
import 'package:todo_app/model/todo.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;

  final VoidCallback loggoutCallBack;

  HomePage({this.auth, this.loggoutCallBack});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textEditingController = TextEditingController();
  List<Todo> _todoList = new List();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Query _todoQuery;
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser.then((currentUser) {
      _todoQuery = _database
          .reference()
          .child("todo")
          .orderByChild("userId")
          .equalTo(currentUser.uid);
      _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(_onEntryAdded);
      _onTodoChangedSubscription =
          _todoQuery.onChildChanged.listen(_onEntryChanged);
    });
  }

  void _onEntryChanged(Event event) {
    setState(() {
      final newEntry = Todo.fromSnapShot(event.snapshot);
      for (int i = 0; i < _todoList.length; i++) {
        final oldEntry = _todoList[i];
        if (newEntry.key == oldEntry.key) {
          _todoList[i] = newEntry;
          break;
        }
      }
    });
  }

  void _onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapShot(event.snapshot));
    });
  }

  @override
  void dispoase() {
    _onTodoChangedSubscription.cancel();
    _onTodoAddedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter login demo'),
          actions: [
            FlatButton(
              child: Text('Logout',
                  style: TextStyle(fontSize: 17, color: Colors.white)),
              onPressed: () {
                widget.auth.signOut().then((_) {
                  widget.loggoutCallBack();
                });
              },
            ),
          ],
        ),
        body: showTodoList(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showTodoDialog(context);
          },
        ));
  }

  Widget showTodoList(BuildContext context) {
    if (_todoList.isEmpty) {
      return Center(
          child: Text(
        'your todo list is empty',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }

    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (BuildContext context, int index) {
        final Todo entry = _todoList[index];

        return ListTile(
          title: Text(entry.subject, style: TextStyle(fontSize: 20)),
          trailing: IconButton(
            icon: entry.completed
                ? Icon(
                    Icons.done_outline,
                    color: Colors.green,
                    size: 20.0,
                  )
                : Icon(
                    Icons.done,
                    color: Colors.grey,
                    size: 20.0,
                  ),
            onPressed: () {
              entry.completed = !entry.completed;
              _updateTodo(entry);
            },
          ),
        );
      },
    );
  }

  showTodoDialog(BuildContext context) async {
    _textEditingController.clear();

    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Add new todo',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: const Text('cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: const Text('add'),
                onPressed: () {
                  _addNewTodo(_textEditingController.text);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _addNewTodo(String todoContent) async {
    if (todoContent.isNotEmpty) {
      final user = await widget.auth.currentUser;
      Todo todo =
          Todo(userId: user.uid, completed: false, subject: todoContent);

      _database.reference().child('todo').push().set(todo.toJson());
    }
  }

  void _updateTodo(Todo todo) {
    if (todo == null) {
      return;
    }

    _database.reference().child('todo').child(todo.key).set(todo.toJson());
  }
}
