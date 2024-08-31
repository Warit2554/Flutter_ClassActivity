import 'package:flutter/material.dart';
import 'package:hw03/login.dart';
import 'package:hw03/models/users.dart';
import 'package:hw03/main.dart';

class Userinfo extends StatelessWidget{
  const Userinfo({super.key, required Users user});
  
  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as Users;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info",),
      ),
      body: Container(
        margin:const EdgeInsets.all(10.0),
        child: Card(
          child: ListView(
            children: [
              ListTile(title: Text("Full name"),subtitle:  Text("${user.fullname}"),),
              ListTile(title: Text("Email"), subtitle: Text("${user.email}"),),
              ListTile(title: Text("Gender"),subtitle: Text("${user.gender}"),)
            ],
          ),
        ),
      ),
    );
  }
}