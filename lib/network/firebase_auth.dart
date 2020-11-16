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


    Future<FirebaseUser> get currentUser async => await _firebaseAuth.currentUser();

    Future<void> sendEmailVerification() async{

        final user = await currentUser;
        user.sendEmailVerification();

    }

    Future<void> signOut() => _firebaseAuth.signOut();

    Future<bool> isEmailVerified() async {
        FirebaseUser user = await _firebaseAuth.currentUser();
        return user.isEmailVerified;
    }


}

