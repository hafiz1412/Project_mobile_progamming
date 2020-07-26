import 'package:flutter/material.dart';

void main() => runApp(NewsOTScreen());

class NewsOTScreen extends StatefulWidget {
  @override
  _NewsOTScreenState createState() => _NewsOTScreenState();
}

class _NewsOTScreenState extends State<NewsOTScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromRGBO(255, 237, 0, 5),
          title: Container(
            child: Center(
              child: Text(
                'NEWS ON THE ROAD',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roadtrack',
                    fontSize: 35,),
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(52, 61, 65, 5),
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            upperLayer(context),
          ],
        ));
  }

  Widget upperLayer(BuildContext context) {
    return Container();
  }
}
