import 'package:flutter/material.dart';
// import 'package:hw03/widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hw03/models/config.dart';
import 'package:hw03/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:hw03/main.dart';
import 'package:hw03/userform.dart';

Users user = Users();
final _formKey = GlobalKey<FormState>();


class Login extends StatefulWidget {
  static const routeName = "/login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(title: const Text("Login",textScaleFactor: 2 ,),),
            emailInputField(),
            passwordInputField(),
            SizedBox(height: 10.0,),
            Row(
              children: [
                submitButton(context),
                SizedBox(width: 10.0,),
                backButton(),
                SizedBox(width: 10.0,),
                registerLink()
                
              ],
            )
          ],
          )
        ),
      ),
    );
  }
}



Future<void> login(BuildContext context, Users user) async {
  var params = {"email": user.email, "password": user.password};

  var url = Uri.http(Configure.server, "users", params);
  var resp = await http.get(url);
  print(resp.body);
  List<Users> login_result = usersFromJson(resp.body);

  if (login_result.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Username or password invalid")),
    );
  } else {
    // Store the user's data in Configure.login
    Configure.login = login_result[0];
    
    // After updating the login information, navigate to the home screen
    Navigator.pushNamed(context, Home.routeName);
  }

  return;
}

  Widget emailInputField() {
  return TextFormField(
    initialValue: user.email,
    decoration: InputDecoration(
      labelText: "Email:",
      icon: Icon(Icons.email),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "This field is required";
      }
      if (!EmailValidator.validate(value)) {
        return "It is not in email format";
      }
      return null;
    },
    onSaved: (newValue) => user.email = newValue,
  );
}


Widget passwordInputField() {
  return TextFormField(
    initialValue: user.password,
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Password:",
      icon: Icon(Icons.lock)
    ),
    validator: (value) {
      if (value!.isEmpty){
        return "This field is required";
      }
      return null;
    },
    onSaved: (newValue) => user.password = newValue,
  );
}

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          print(user.toJson().toString());
          login(context, user); // Pass the context here
        }
      },
      child: Text("Login"),
    );
  }

Widget backButton() {
  return ElevatedButton(onPressed: () {} 
  , child: Text("Back"));
}

Widget registerLink() {
  return InkWell(child: const Text("Sign Up") 
  , onTap: () {} );
}

Widget fnameInputField() {
  return TextFormField(
    initialValue: user.fullname,
    decoration: InputDecoration(
      labelText: "Fullname:",
      icon: Icon(Icons.person)
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "This field is required";
      }
      return null;
    },
    onSaved: (newValue) => user.fullname = newValue,
  );
}

Widget genderFormInput() {
  var initGen = "None";
  try {
    if (!user.gender!.isEmpty) {
      initGen = user.gender!;
    }
  } catch (e) {
    initGen = "None";
  }


  return DropdownButtonFormField(decoration:InputDecoration(labelText: "Gender", icon: Icon(Icons.man)), 
  items: Configure.gender.map((String val){
    return DropdownMenuItem(
      value: val,
      child: Text(val),
      );
  }).toList(), 
  onChanged: (value) {
    user.gender = value;
  },
  onSaved: (newValue) => user.gender,);
}

