import 'package:flutter/material.dart';
import 'package:todo_app/ui/login/login_signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
    
    @override
    Widget build(BuildContext context){
        return MaterialApp(
                title: 'flutter login app',
                theme: ThemeData(
                        primarySwatch: Colors.blue,
                ),
                home: LoginSignupPage(),
        );
    }
}
