import 'package:flutter/material.dart';
import 'package:todo_app/network/firebase_auth.dart';
class HomePage extends StatelessWidget {

    final BaseAuth auth;

    final VoidCallback loggoutCallBack;

    HomePage({this.auth, this.loggoutCallBack});


    @override
    Widget build(BuildContext context){

        return Scaffold(
                appBar: AppBar(
                        title: Text('Flutter login demo'),
                ),

                body: Container(
                        child: Center(
                                child: Text('Home page'),
                        ),
                ),
                floatingActionButton:  FloatingActionButton(

                        child: Icon(Icons.exit_to_app),
                        onPressed  : () {

                            auth.signOut().then((_){
                                this.loggoutCallBack();
                            });
                        },
                )
        );

    }

}
