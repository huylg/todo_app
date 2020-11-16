import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget{

    @override
    _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage>{

    String _errorMessage = '';
    String _password = '';
    bool _isLoginForm = true;
    bool _isLoading = false;
    String _email = '';
    @override
    Widget build(BuildContext context){
        return Scaffold(

                appBar: AppBar(title: Text('Todo App')),
                body: Stack(
                        children: [
                            showForm(),
                            showCircularProgress(),
                        ],
                ),
        );
    }


    Widget showCircularProgress() => _isLoading ? CircularProgressIndicator() : Container(height: 0,width: 0);

    Widget showLogo(){
        return Hero(
                tag: 'hero',
                child: Padding(
                        padding:  EdgeInsets.fromLTRB(0,100,0,0),
                        child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 40.0,
                                child: Image.asset('assets/flutter-icon.png'),
                        ),
                ),
        );

    }

    Widget showEmailInput(){
        return Padding(
                padding: const EdgeInsets.fromLTRB(0,50,0,0),
                child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                                hintText: 'Email',
                                icon: Icon(Icons.mail, color: Colors.grey,),
                        ),
                        validator: (value) => value.isEmpty ? "email can\'t be empty" : null,
                        onSaved: (value) => _email = value.trim(),
                ),
        );
    }

    Widget showPasswordInput(){
        return Padding(
                padding: const EdgeInsets.fromLTRB(0,15,0,0),
                child: TextFormField(
                        maxLines: 1,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                                hintText: 'Password',
                                icon: Icon(Icons.lock, color: Colors.grey,),
                        ),
                        validator: (value) => value.isEmpty ? 'password can\'t be empty' : null,
                        onSaved: (value) => _password = value.trim(),
                )
        );
    }

    Widget showPrimaryButton(){
        return Padding(
                padding: EdgeInsets.fromLTRB(0,45,0,0),
                child: SizedBox(
                        height: 40.0,
                        child: RaisedButton(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0)
                                ),
                                color: Colors.blue,
                                child: Text(_isLoginForm ? 'Login' : 'Create account', style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                onPressed: validateAndSubmit,
                        ),
                ),
        );
    }

    void validateAndSubmit(){

        setState(() {
                  _errorMessage = '';
                  _isLoading = true;
                });

        if(validateAndSave()){
            String userId = "";
        }else{

        }



    }

    Widget showSecondaryButton(){

        return FlatButton(
                child: Text(
                        _isLoginForm ? 'Create an account' : 'Have a account? login',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                onPressed: toggleFormMode,
        );

    }

    void toggleFormMode(){
        //resetForm();

        setState(() {
            _isLoginForm = !_isLoginForm;
        });
    }

    Widget showErrorMessage() => _errorMessage == null || _errorMessage.isEmpty ?
            Text(_errorMessage,
                    style: TextStyle(fontSize: 13.0, color: Colors.red, height: 1.0, fontWeight: FontWeight.w300)) : Container(height: 0);

    final _formKey = GlobalKey<FormState>();

    Widget showForm(){
        return Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                        key: _formKey,
                        child: ListView(
                                shrinkWrap:  true,
                                children: [
                                    showLogo(),
                                    showEmailInput(),
                                    showPasswordInput(),
                                    showPrimaryButton(),
                                    showSecondaryButton(),
                                    showErrorMessage(),
                                ],
                        ),
                )
        );

    }


}
