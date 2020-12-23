import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
              widget.toggleView();
          }, icon: Icon(Icons.person_add), label: Text('Register'))
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
        child: Form(
          key:_formKey,
          child: Column(
            children:<Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter your email'),
                  validator: (val)=> val.isEmpty?'Enter your email':null,
                onChanged: (val){
                    setState(()=> email =val);
                }
              ),
              SizedBox(height:20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Enter your password'),
                  validator: (val)=> val.length<8?'Enter your password with 8 or more characters':null,
                obscureText: true,
                onChanged:(val){
                  setState(()=> password =val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color:Colors.brown[400],
                child:Text('Sign In',
                  style: TextStyle(color:Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() => loading=true);
                    dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState((){ error="The email or password doesn't exist. Please register to continue";loading=false;});
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                  error,
                  style:TextStyle(color: Colors.red, fontSize: 14.0)
              )
            ]
          )
        ),
      ),
    );
  }
}
