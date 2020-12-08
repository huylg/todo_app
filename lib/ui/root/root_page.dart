import 'package:todo_app/ui/login/login_signup_page.dart';
import 'package:todo_app/ui/main/home_page.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/network/firebase_auth.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;

  RootPage({Key k, this.auth}) : super(key: k);

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  NOT_DETERTMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  void loginCallBack() {
    widget.auth.currentUser.then((user) {
      setState(() {
        _userId = user.uid;
        status = AuthStatus.LOGGED_IN;
      });
    });

    setState(() {
      status = AuthStatus.NOT_DETERTMINED;
    });
  }

  void logoutCallBack() {
    widget.auth.signOut().then((_) {
      setState(() {
        _userId = '';
        status = AuthStatus.NOT_LOGGED_IN;
      });
    });

    setState(() {
      status = AuthStatus.NOT_DETERTMINED;
    });
  }

  String _userId;
  AuthStatus status = AuthStatus.NOT_DETERTMINED;

  @override
  void initState() {
    widget.auth.currentUser.then((user) {
      setState(() {
        status = (user == null || user.uid.isEmpty)
            ? AuthStatus.NOT_LOGGED_IN
            : AuthStatus.LOGGED_IN;
      });
    });
  }

  @override
  build(BuildContext context) {
    switch (status) {
      case AuthStatus.NOT_DETERTMINED:
        return builWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignupPage(auth: Auth(), callback: loginCallBack);
        break;
      case AuthStatus.LOGGED_IN:
        return HomePage(
          auth: Auth(),
          loggoutCallBack: logoutCallBack,
        );
        break;
      default:
        return builWaitingScreen();
        break;
    }
  }

  Widget builWaitingScreen() {
    return Scaffold(
        appBar: AppBar(title: Text('Todo app')),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
