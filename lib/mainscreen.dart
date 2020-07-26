import 'package:e_aduan_final/complaintscreen.dart';
import 'package:e_aduan_final/eaduanshop.dart';
import 'package:e_aduan_final/loginscreen.dart';
import 'package:e_aduan_final/newsorscreen.dart';
import 'package:e_aduan_final/profilescreen.dart';
import 'package:e_aduan_final/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    ThemeData.dark();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Color.fromRGBO(255, 237, 0, 5),
            title: Center(
              child: _getTextImage(),
            ),
          ),
          backgroundColor: Color.fromRGBO(52, 61, 65, 5),
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
    ThemeData.dark();
    return Container(
      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
      // width: 100,height: 100,
      child: Image.asset(
        'images/eaduanmainv2.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget upperLayer(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 230, left: 50, right: 50, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              splashColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellowAccent),
                  borderRadius: BorderRadius.circular(100)),
              minWidth: 300,
              height: 50,
              child: Text('Profile',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 16)),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 10,
              onPressed: this._profileScreen,
            ),
            MaterialButton(
              splashColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellowAccent),
                  borderRadius: BorderRadius.circular(100)),
              minWidth: 300,
              height: 50,
              child: Text('Write Your Complaint',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 16)),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 10,
              onPressed: this._writeComplaint,
            ),
            MaterialButton(
              splashColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellowAccent),
                  borderRadius: BorderRadius.circular(100)),
              minWidth: 300,
              height: 50,
              child: Text('News On The Road',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 16)),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 10,
              onPressed: this._newsOnRoad,
            ),
            MaterialButton(
              splashColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellowAccent),
                  borderRadius: BorderRadius.circular(100)),
              minWidth: 300,
              height: 50,
              child: Text('E-ADUAN Shop',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 16)),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 10,
              onPressed: this._eaduanShop,
            ),
            MaterialButton(
              splashColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellowAccent),
                  borderRadius: BorderRadius.circular(100)),
              minWidth: 300,
              height: 50,
              child: Text('Log Out',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 16)),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 10,
              onPressed: _loginScreen,
            ),
          ],
        ));
  }

  Widget _getTextImage() {
    var assetImage = AssetImage("images/eaduanwarning.png");
    var image = new Image(
      image: assetImage,
      width: 60,
      fit: BoxFit.cover,
    );
    final ListTile listTile = new ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text(
              "E-ADUAN",
              style: TextStyle(
                  fontFamily: 'Roadtrack', color: Colors.black, fontSize: 62),
            ),
          ],
        ),
        trailing: image);
    return listTile;
  }

  void _profileScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen(user: widget.user)));
  }

  void _writeComplaint() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ComplaintScreen(user: widget.user)));
  }

  void _newsOnRoad() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewsOTScreen()));
  }

  void _eaduanShop() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EaduanShop(user: widget.user)));
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
}
