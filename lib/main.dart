import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  var DateOfBirth;
  changePassword(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PasswordChange()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: Text("Account Details", style: TextStyle(fontSize: 25.0)),
          ),
          Container(
              width: 350,
              child: TextField(
                controller: firstName,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: 'Enter First Name',
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.account_circle),
                    )),
              )),
          Container(
              width: 350,
              child: TextField(
                controller: lastName,
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: 'Enter Last Name',
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.account_circle),
                    )),
              )),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                onPressed: () => changePassword(context),
                color: Colors.yellow,
                textColor: Colors.black,
                child: Text('Forgot Password ?'),
              )),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2020, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  DateOfBirth = newDateTime;
                });
              },
            ),
          ),
          Column(
            children: [DropDownList()],
          ),
        ],
      ),
    ));
  }
}

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  static String _mySelection;
  final String url = "https://api.printful.com/countries";
  var _category = null;
  List data = List();
  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody['result'];
    });

    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButton(
        hint: Text("Choose Country"),
        items: data.map((item) {
          return DropdownMenuItem(
            child: Text(item['name']),
            value: item['code'].toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _mySelection = newVal;
          });
        },
        value: _mySelection,
      ),
      RaisedButton(
        onPressed: (_mySelection == "CA")
            ? () {
                Fluttertoast.showToast(
                  msg: "Profile Saved",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
              }
            : null,
        color: _category == null ? Colors.orangeAccent : Colors.grey,
        textColor: Colors.black,
        child: Text('Submit'),
      )
    ]);
  }
}

class submitButton extends StatefulWidget {
  @override
  _submitButtonState createState() => _submitButtonState();
}

class _submitButtonState extends State<submitButton> {
  var _category = null;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
    );
  }
}

class PasswordChange extends StatefulWidget {
  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PasswordChangeActivity",
      home: Scaffold(
        appBar: AppBar(title: Text("Change Password")),
        body: ChangePasswordScreen(),
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  ValidateEmailPassword(BuildContext context) {
    var emailHolder = email.text;

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailHolder);
    if (emailValid) {
      Fluttertoast.showToast(
        msg: "Password Changed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Invalid Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                width: 350,
                child: TextField(
                  controller: email,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: 'Enter Email',
                      icon: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(Icons.account_circle),
                      )),
                )),
            Container(
                width: 350,
                child: TextField(
                  obscureText: true,
                  controller: password,
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Enter New Password',
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.lock),
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  onPressed: () => ValidateEmailPassword(context),
                  color: Colors.yellow,
                  textColor: Colors.black,
                  child: Text('Change Password'),
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    )
                  },
                  color: Colors.yellow,
                  textColor: Colors.black,
                  child: Text('Go Back'),
                ))
          ],
        ),
      ),
    );
  }
}
