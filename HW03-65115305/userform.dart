import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hw03/main.dart';
import 'package:hw03/login.dart';
import 'package:hw03/models/config.dart';
import 'package:hw03/models/users.dart';
import 'dart:math';

String generateRandomId(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}

final _formKey = GlobalKey<FormState>();

class UserForm extends StatefulWidget {
  static const routeName = "/userform";

  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  late Users user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      user = ModalRoute.of(context)!.settings.arguments as Users;
      _fullnameController.text = user.fullname!;
    } catch (e) {
      user = Users();
    }
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fnameInputField(_fullnameController),
              emailInputField(),
              passwordInputField(),
              genderFormInput(),
              SizedBox(height: 10),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNewUser(Users user) async {
    if (user.id == null || user.id!.isEmpty) {
      user.id = generateRandomId(10); // Generate a random ID with 10 characters
    }
    var url = Uri.http(Configure.server, "users");
    var resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
  }

  Future<void> updateData(Users user) async {
    var url = Uri.http(Configure.server, "users/${user.id}");
    var resp = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (user.id == null || user.id!.isEmpty) {
            print("Adding new user");
            addNewUser(user);
          } else {
            print("Updating existing user");
            updateData(user);
          }
        }
      },
      child: Text("Save"),
    );
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
      onSaved: (newValue) => user.email = newValue ?? '',
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: user.password,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password:",
        icon: Icon(Icons.lock),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue ?? '',
    );
  }

  Widget fnameInputField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Fullname:",
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.fullname = newValue ?? '',
    );
  }

  Widget genderFormInput() {
    var initGen = "None";
    if (user.gender != null && user.gender!.isNotEmpty) {
      initGen = user.gender!;
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: "Gender", icon: Icon(Icons.man)),
      value: initGen,
      items: Configure.gender.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          user.gender = value;
        });
      },
      onSaved: (newValue) => user.gender = newValue,
    );
  }
}
