import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:e_aduan_final/user.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'mainscreen.dart';
import 'package:e_aduan_final/registerscreen.dart';

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  String urlLogin = "http://shabab-it.com/e_aduan_final/php/login_user.php";

  @override
  void initState() {
    super.initState();
    print("Welcome to INITSTATE");
    this.loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              backGround(context),
              upperLayer(context),
            ],
          )),
    );
  }

  Widget backGround(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/splashscreeneaduan.jpg'),
                fit: BoxFit.fill)));
  }

  Widget upperLayer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                margin: EdgeInsets.only(left: 10, right: 10, top: 105),
                elevation: 10,
                child: Container(
                  color: Colors.yellowAccent,
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Colors.black),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                  cursorColor: Colors.black,
                                  cursorRadius: Radius.circular(16),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  controller: _emailEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    icon: Icon(
                                      Icons.email,
                                    ),
                                  )),
                              TextField(
                                cursorColor: Colors.black,
                                cursorRadius: Radius.circular(16),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _passEditingController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: Icon(
                                    Icons.lock,
                                  ),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
                            splashColor: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            minWidth: 100,
                            height: 50,
                            child: Text('Log In',
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 16)),
                            color: Colors.black,
                            textColor: Colors.white,
                            elevation: 10,
                            onPressed: this._userLoginScreen,
                          ),
                          MaterialButton(
                            splashColor: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            minWidth: 100,
                            height: 50,
                            child: Text('Sing Up',
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 16)),
                            color: Colors.black,
                            textColor: Colors.white,
                            elevation: 10,
                            onPressed: this._registerNewUser,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            activeColor: Colors.black,
                            checkColor: Colors.yellowAccent,
                            value: rememberMe,
                            onChanged: (bool value) {
                              _onRememberMeChanged(value);
                            },
                          ),
                          Text('Remember Me ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Forgot your password?",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                          GestureDetector(
                            onTap: _forgotPassword,
                            child: Text(
                              " Reset Password",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("New user? Please click",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                          Text(
                            " Sing UP ",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text("button",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _registerNewUser() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  void _userLoginScreen() async {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(
          progress: 50,
          // message: "Log in...",
          messageTextStyle: TextStyle(color: Colors.yellowAccent, fontSize: 16),
          backgroundColor: Colors.black);
      Future.delayed(Duration(seconds: 2)).then((onvalue) {
        pr.update(
          message: "Please wait...",
          progressWidget: Container(
              padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
              color: Colors.yellowAccent,
              fontSize: 13.0,
              fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.yellowAccent,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        );
      });
      pr.show();
      String _email = _emailEditingController.text;
      String _password = _passEditingController.text;
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      })
          // .timeout(const Duration(seconds: 4))
          .then((res) {
        print(res.body);
        var string = res.body;
        List userdata = string.split(",");
        if (userdata[0] == "success") {
          User _user = new User(
              name: userdata[1],
              email: _email,
              password: _password,
              phone: userdata[3],
              credit: userdata[4],
              datereg: userdata[5],
              quantity: userdata[6]);
          pr.hide();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(
                        user: _user,
                      )));
        } else {
          pr.hide();
          Toast.show("Login failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        }
      }).catchError((err) {
        print(err);
        pr.hide();
      });
    } on Exception catch (_) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  void _forgotPassword() {
    TextEditingController phoneController = TextEditingController();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.yellowAccent,
          title: new Text(
            "Forgot Password?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: new Container(
            height: 100,
            child: Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.black),
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter your recovery email",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                      cursorColor: Colors.black,
                      cursorRadius: Radius.circular(16),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ))
                ],
              ),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                print(
                  phoneController.text,
                );
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        print(rememberMe);
        if (rememberMe) {
          savepref(true);
        } else {
          savepref(false);
        }
      });

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Colors.yellowAccent[700],
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
        rememberMe = true;
      });
    }
  }

  void savepref(bool value) async {
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Toast.show("Preferences have been saved", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        rememberMe = false;
      });
      Toast.show("Preferences have removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }
}
