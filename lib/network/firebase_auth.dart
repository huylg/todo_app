import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{

    Future<String> signIn(String email, String password);

    Future<String> signUp(String email, String password);

    Future<FirebaseUser> get currentUser;

    Future<void> sendEmailVerification();

    Future<void> signOut();

    Future<bool> isEmailVerified();
}

class Auth implements BaseAuth{

    FirebaseUser _currentUser = null;

    final _firebaseAuth = FirebaseAuth.instance;

    Future<String> signIn(String email, String password) async{

        final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return user.uid;
    }


    Future<String> signUp(String email, String password) async {

        final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return user.uid;
    }


    Future<FirebaseUser> get currentUser async {
        if(_currentUser == null){
                
            _currentUser = await _firebaseAuth.currentUser();
        }

        return _currentUser;
    } 

    Future<void> sendEmailVerification() async{

        final user = await currentUser;
        user.sendEmailVerification();

    }

    Future<void> signOut() async{
        _firebaseAuth.signOut().then((_){
           _currentUser = null; 
        });
    }

    Future<bool> isEmailVerified() async {
        FirebaseUser user = await _firebaseAuth.currentUser();
        return user.isEmailVerified;
    }


}

