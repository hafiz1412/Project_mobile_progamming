import 'package:e_aduan_final/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double screenHeight;
  bool _isChecked = false;
  String urlRegister =
      "http://shabab-it.com/e_aduan_final/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          backGround(context),
          upperLayer(context),
        ],
      ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            children: <Widget>[
              Card(
                margin:
                    EdgeInsets.only(top: screenHeight / 9, left: 10, right: 10),
                color: Colors.yellowAccent,
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Center(
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
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
                                  controller: _nameEditingController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    fillColor: Colors.black,
                                    icon: Icon(Icons.person),
                                  )),
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
                                    icon: Icon(Icons.email),
                                  )),
                              TextField(
                                  cursorColor: Colors.black,
                                  cursorRadius: Radius.circular(16),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  controller: _phoneditingController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: 'Phone',
                                    icon: Icon(Icons.phone_android),
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
                                  icon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Checkbox(
                            value: _isChecked,
                            checkColor: Colors.yellowAccent,
                            activeColor: Colors.black,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          GestureDetector(
                            onTap: _showEULA,
                            child: Text('I Agree to Terms  ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          MaterialButton(
                            splashColor: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            minWidth: 115,
                            height: 50,
                            child: Text(
                              'Sing Up',
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 16),
                            ),
                            color: Colors.black,
                            textColor: Colors.black,
                            elevation: 10,
                            onPressed: _onRegister,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already register? ",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                          GestureDetector(
                            onTap: _loginScreen,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      )
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

  void _onRegister() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneditingController.text;
    String password = _passEditingController.text;
    if (!_isChecked) {
      Toast.show("Please Accept Term", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    if (name == null) {
      Toast.show("Please Enter Your Name", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    if (email == null) {
      Toast.show("Please Enter Your Email", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    if (phone == null) {
      Toast.show("Please Enter Your Phone Number", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    if (password == null) {
      Toast.show("Please Enter Your Password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    http.post(urlRegister, body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.yellowAccent,
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and E-Aduan This EULA agreement governs your acquisition and use of our E-Aduan software (Software) directly from E-Aduan or indirectly through a E-Aduan authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the E-Aduan software. It provides a license to use the E-Aduan software and contains warranty information and liability disclaimers. If you register for a free trial of the E-Aduan software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the E-Aduan software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by E-Aduan herewith regardless of whether other software is referred to or described herein. The terms also apply to any E-Aduan updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for E-Aduan. E-Aduan shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of E-Aduan. E-Aduan reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.black,
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.yellowAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
