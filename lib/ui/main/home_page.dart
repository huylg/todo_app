import 'package:flutter/material.dart';
import 'package:todo_app/network/firebase_auth.dart';
import 'package:todo_app/repo/todo_repo.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;

  final VoidCallback loggoutCallBack;

  HomePage({this.auth, this.loggoutCallBack});

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  bool _isLoading = true;
  
  TodoRepository repo;

  @override
  void initState(){

    widget.auth.currentUser.then((user){
      setState(() {
              _isLoading = false;
              repo = TodoRepository(user.uid);
            });
    });

  }

  @override
  Widget build(BuildContext context) {
    
    if(_isLoading){
      return Center(child: CircularProgressIndicator(),);
    }

    

    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter login demo'),
        ),
        body: Container(
          child: Center(
            child: Text('Home page'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.exit_to_app),
          onPressed: () {
            widget.auth.signOut().then((_) {
              widget.loggoutCallBack();
            });
          },
        ));
  }
}
