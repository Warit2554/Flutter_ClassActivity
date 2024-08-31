import 'package:flutter/material.dart';
import 'package:hw03/main.dart';
import 'package:hw03/login.dart';
import 'package:hw03/models/config.dart';
import 'package:hw03/models/users.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accName = "N/A";
    String accEmail = "N/A";
    String accUrl = "https://imgtr.ee/images/2024/08/20/e044b3d98716c3c67db3362d47ead89c.jpeg";

    // Retrieve the user info from Configure.login
    Users user = Configure.login;

    if (user.id != null) {
      accName = user.fullname!;
      accEmail = user.email!;
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accName),
            accountEmail: Text(accEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accUrl),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
              print('Push home');
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
              print('Push Login');
            },
          ),
        ],
      ),
    );
    
  }
  
}