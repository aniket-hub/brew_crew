import 'package:brew_crew/Screens/Authenticate/authenticate.dart';
import 'package:brew_crew/Screens/Home/home.dart';
import 'package:brew_crew/models/user.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);

    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}
