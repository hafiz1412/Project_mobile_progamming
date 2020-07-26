import 'dart:convert';
import 'dart:io';
import 'package:e_aduan_final/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'loginscreen.dart';
import 'registerscreen.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String server = "http://shabab-it.com/e_aduan_final";
  double screenHeight, screenWidth;
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  var parsedDate;

  @override
  void initState() {
    super.initState();
    print("profile screen");
    // DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    parsedDate = DateTime.parse(widget.user.datereg);

    return Scaffold(
      backgroundColor: Color.fromRGBO(52, 61, 65, 5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellowAccent,
        title: Text(
          'USER PROFILE',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roadtrack', fontSize: 40),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            Card(
              color: Colors.black,
              elevation: 50,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _takePicture,
                          child: Container(
                            height: screenHeight / 4,
                            width: screenWidth / 3,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.black),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: server +
                                  "/userprofileimages/${widget.user.email}.jpg?",
                              placeholder: (context, url) => new SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  new Icon(MdiIcons.cameraIris, size: 64.0),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: Container(
                          // color: Colors.red,
                          child: Table(
                              defaultColumnWidth: FlexColumnWidth(1.0),
                              columnWidths: {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(5),
                              },
                              children: [
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 20,
                                        child: Text("Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellowAccent))),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      child: Text(widget.user.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.yellowAccent)),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 20,
                                        child: Text("Email",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellowAccent))),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      child: Text(widget.user.email,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.yellowAccent)),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 20,
                                        child: Text("Phone",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellowAccent))),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      child: Text(widget.user.phone,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.yellowAccent)),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 20,
                                        child: Text("Register Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellowAccent))),
                                  ),
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      child: Text(f.format(parsedDate),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.yellowAccent)),
                                    ),
                                  ),
                                ]),
                              ]),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 10),
              child: Center(
                child: Text("SET YOUR PROFILE",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent)),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.yellowAccent,
            ),
            Expanded(
                //color: Colors.red,
                child: ListView(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    shrinkWrap: true,
                    children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    splashColor: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellowAccent),
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 300,
                    height: 50,
                    child: Text("CHANGE YOUR NAME",
                        style: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16)),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: changeName,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    splashColor: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellowAccent),
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 300,
                    height: 50,
                    child: Text("CHANGE YOUR PASSWORD",
                        style: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16)),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: changePassword,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    splashColor: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellowAccent),
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 300,
                    height: 50,
                    child: Text("CHANGE YOUR PHONE",
                        style: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16)),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: changePhone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    splashColor: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellowAccent),
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 300,
                    height: 50,
                    child: Text("MAIN SCREEN",
                        style: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16)),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: _mainScreen,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    splashColor: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellowAccent),
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 300,
                    height: 50,
                    child: Text('REGISTER NEW ACCOUNT',
                        style: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16)),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: _registerAccount,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    splashColor: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellowAccent),
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 300,
                    height: 50,
                    child: Text("LOG OUT",
                        style: TextStyle(
                            color: Colors.yellowAccent, fontSize: 16)),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: _loginScreen,
                  ),
                ])),
          ],
        ),
      ),
    );
  }

  void _takePicture() async {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    // ignore: deprecated_member_use
    File _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 300);
    //print(_image.lengthSync());
    if (_image == null) {
      Toast.show("Please take image first", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    } else {
      String base64Image = base64Encode(_image.readAsBytesSync());
      print(base64Image);
      http.post(server + "/php/upload_image.php", body: {
        "encoded_string": base64Image,
        "email": widget.user.email,
      }).then((res) {
        print(res.body);
        if (res.body == "success") {
          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
          });
        } else {
          Toast.show("Failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  void changeName() {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    if (widget.user.email == "admin@eaduan.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.yellowAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your name?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: new Theme(
                data: Theme.of(context).copyWith(primaryColor: Colors.black),
                child: TextField(
                    cursorColor: Colors.black,
                    cursorRadius: Radius.circular(16),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    )),
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.yellow[900],
                      ),
                    ),
                    onPressed: () =>
                        _changeName(nameController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changeName(String name) {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    if (name == "" || name == null) {
      Toast.show("Please enter your new name", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    ReCase rc = new ReCase(name);
    print(rc.titleCase.toString());
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "name": rc.titleCase.toString(),
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.name = rc.titleCase;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePassword() {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    TextEditingController passController = TextEditingController();
    TextEditingController pass2Controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.yellowAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your password?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: new Theme(
                data: Theme.of(context).copyWith(primaryColor: Colors.black),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                        cursorColor: Colors.black,
                        cursorRadius: Radius.circular(16),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        )),
                    TextField(
                        cursorColor: Colors.black,
                        cursorRadius: Radius.circular(16),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        obscureText: true,
                        controller: pass2Controller,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(color: Colors.yellow[900]),
                    ),
                    onPressed: () => updatePassword(
                        passController.text, pass2Controller.text)),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  updatePassword(String pass1, String pass2) {
    if (pass1 == "" || pass2 == "") {
      Toast.show("Please enter your password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }

    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "oldpassword": pass1,
      "newpassword": pass2,
    }).then((res) {
      if (res.body == "success") {
        print('in success');
        setState(() {
          widget.user.password = pass2;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePhone() {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    TextEditingController phoneController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.yellowAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your phone number?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: new Theme(
                data: Theme.of(context).copyWith(primaryColor: Colors.black),
                child: TextField(
                    cursorColor: Colors.black,
                    cursorRadius: Radius.circular(16),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'New Phone Number',
                      icon: Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ),
                    )),
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.yellow[900],
                      ),
                    ),
                    onPressed: () =>
                        _changePhone(phoneController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changePhone(String phone) {
    if (phone == "" || phone == null || phone.length < 9) {
      Toast.show("Please enter your new phone number", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.phone = phone;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void _loginScreen() {
    // flutter defined function
    print(widget.user.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.yellowAccent[700],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Log out?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.yellow[900],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.yellow[900],
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

  void _registerAccount() {
    // flutter defined function
    print(widget.user.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.yellowAccent[700],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Register new account?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.yellow[900],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RegisterScreen()));
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.yellow[900],
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

  void _mainScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MainScreen(user: widget.user)));
  }
}
