import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hw03/models/config.dart';
import 'package:hw03/models/users.dart';
import 'package:hw03/sidemenu.dart';
import 'package:hw03/login.dart';
import 'package:http/http.dart' as http;
import 'package:hw03/userinfo.dart';
import 'package:hw03/userform.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
        '/userform' : (context) => const UserForm()
      },
    );
  }
}

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = Container();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blue,
      ),
      drawer: const SideMenu(),
      body: mainBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
                  String result = await Navigator.push(
                    context , MaterialPageRoute(builder: (context) => UserForm())
       

                  );
                  if(result == "refresh"){
                    getUsers();
                  }
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }

  Widget showUsers() {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        Users user = _userList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          child: Card(
            child: ListTile(
              title: Text("${user.fullname}"),
              subtitle: Text("${user.email}"),
              onTap: () {
                print('Push what the fuck Login');
              },
              trailing: IconButton(
                onPressed: () async {
                  String result = await Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => UserForm(),
                  settings: RouteSettings(arguments: user)));
                if(result == "refresh"){
                  getUsers();
                }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Userinfo(user: user,),
                  //       settings: RouteSettings(arguments: user)),
                  // );
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ),
          onDismissed: (direction) {
            removeUsers(user);
            
           },
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color:Colors.white,),
            
          ),
        );
      },
    );
  }

  List<Users> _userList = [];

  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.get(url);
    setState(() {
      _userList = usersFromJson(resp.body);
      mainBody = showUsers();
      print("hello");
    });
    return;
  }

  Future<void> removeUsers(user) async{
    var url = Uri.http(Configure.server, "users/${user.id}");
    var resp = await http.delete(url);
    print(url);
    print(resp.body);
    return;
  }


}
