import 'dart:io';
import 'dart:async';
import 'package:e_aduan_final/mainscreen.dart';
import 'package:e_aduan_final/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(ComplaintScreen());

class ComplaintScreen extends StatefulWidget {
  final User user;

  const ComplaintScreen({Key key, this.user}) : super(key: key);
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  File _image;
  final _picker = ImagePicker();
  double screenHeight, screenWidth;
  String pathAsset = 'images/iconcamera2.png';
  Position _currentPosition;
  String curaddress;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController gmcontroller;
  CameraPosition _home;
  MarkerId markerId1 = MarkerId("12");
  Set<Marker> markers = Set();
  double latitude, longitude;
  String label;
  CameraPosition _userpos;
  TextEditingController _nameEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromRGBO(255, 237, 0, 5),
          title: Container(
            child: Center(
              child: Text(
                'WRITE YOUR COMPLAINT',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roadtrack',
                  fontSize: 35,
                ),
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
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.yellowAccent),
                    child: Column(children: <Widget>[
                      GestureDetector(
                          onTap: () => {_choose()},
                          child: Container(
                            height: 160,
                            width: 380,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _image == null
                                    ? AssetImage(pathAsset)
                                    : FileImage(_image),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                width: 3.0,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      5.0) //         <--- border radius here
                                  ),
                            ),
                          )),
                    ])),
              ],
            ),
            Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Colors.yellowAccent),
                child: Column(children: <Widget>[
                  Text(
                    'Take Picture',
                    style: TextStyle(color: Colors.yellowAccent, fontSize: 16),
                  )
                ])),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.yellowAccent),
                    child: Column(children: <Widget>[
                      TextFormField(
                        controller: _nameEditingController,
                        cursorColor: Colors.yellowAccent,
                        cursorRadius: Radius.circular(16),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.yellow),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.yellowAccent),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.yellowAccent,
                            )),
                      )
                    ])),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.yellowAccent),
                    child: Column(children: <Widget>[
                      TextFormField(
                        // controller: _nameEditingController,
                        cursorColor: Colors.yellowAccent,
                        cursorRadius: Radius.circular(16),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.yellow),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.yellowAccent),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.yellowAccent,
                            )),
                      )
                    ])),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Theme(
                    data: Theme.of(context)
                        .copyWith(primaryColor: Colors.yellowAccent),
                    child: Column(children: <Widget>[
                      TextFormField(
                        // controller: _nameEditingController,
                        cursorColor: Colors.yellowAccent,
                        cursorRadius: Radius.circular(16),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.yellow),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Write Your Complaint',
                            labelStyle: TextStyle(color: Colors.yellowAccent),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.mode_edit,
                              color: Colors.yellowAccent,
                            )),
                      )
                    ])),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 390,
                      height: 50,
                      child: RaisedButton(
                        splashColor: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellowAccent),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text('Location',
                            style: TextStyle(
                                color: Colors.yellowAccent, fontSize: 16)),
                        color: Colors.black,
                        elevation: 10,
                        onPressed: () => {_loadMapDialog()},
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Table(
                      defaultColumnWidth: FlexColumnWidth(1.0),
                      columnWidths: {
                        0: FlexColumnWidth(7),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 20,
                                child: Text("Your Location",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellowAccent))),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text(curaddress ?? "Address not set",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellowAccent))),
                          )
                        ])
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 190,
                      height: 50,
                      child: RaisedButton(
                        splashColor: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellowAccent),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text('Send',
                            style: TextStyle(
                                color: Colors.yellowAccent, fontSize: 16)),
                        color: Colors.black,
                        elevation: 10,
                        onPressed: _sendComplaint,
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 190,
                      height: 50,
                      child: RaisedButton(
                          splashColor: Colors.yellowAccent,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.yellowAccent),
                              borderRadius: BorderRadius.circular(100)),
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 16)),
                          color: Colors.black,
                          elevation: 10,
                          onPressed: () => {_mainScreen()}),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _choose() async {
    final pickedFile = await _picker.getImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _image = File(pickedFile.path);
    // _image = await ImagePicker.pickImage(
    //     source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    //     print("gege");
    setState(() {});
  }

  void _sendComplaint() {
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
            "Send complaint?",
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
                        builder: (BuildContext context) => MainScreen(user: widget.user)));
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

  _getLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    _currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${_currentPosition.latitude}');
    final coordinates =
        new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _getLocationfromlatlng(double lat, double lng, newSetState) async {
    final Geolocator geolocator = Geolocator()
      ..placemarkFromCoordinates(lat, lng);
    _currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${_currentPosition.latitude}');
    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    newSetState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });
    setState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _loadMapDialog() {
    try {
      if (_currentPosition.latitude == null) {
        Toast.show("Location not available. Please wait...", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _getLocation(); //_getCurrentLocation();
        return;
      }
      _controller = Completer();
      _userpos = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );

      markers.add(Marker(
          markerId: markerId1,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'Your Location',
          )));

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, newSetState) {
              return AlertDialog(
                backgroundColor: Colors.yellowAccent[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Text(
                  "Select Your Location",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                titlePadding: EdgeInsets.all(5),
                //content: Text(curaddress),
                actions: <Widget>[
                  Text(
                    curaddress,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: screenHeight / 2 ?? 600,
                    width: screenWidth ?? 360,
                    child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _userpos,
                        markers: markers.toSet(),
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                        },
                        onTap: (newLatLng) {
                          _loadLoc(newLatLng, newSetState);
                        }),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    //minWidth: 200,
                    height: 30,
                    child: Text('Close'),
                    color: Colors.black,
                    textColor: Colors.yellowAccent,
                    elevation: 10,
                    onPressed: () =>
                        {markers.clear(), Navigator.of(context).pop(false)},
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  void _loadLoc(LatLng loc, newSetState) async {
    newSetState(() {
      print("insetstate");
      markers.clear();
      latitude = loc.latitude;
      longitude = loc.longitude;
      _getLocationfromlatlng(latitude, longitude, newSetState);
      _home = CameraPosition(
        target: loc,
        zoom: 14,
      );
      markers.add(Marker(
          markerId: markerId1,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'New Location',
            snippet: 'New Current Location',
          )));
    });
    _userpos = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    _newhomeLocation();
  }

  Future<void> _newhomeLocation() async {
    gmcontroller = await _controller.future;
    gmcontroller.animateCamera(CameraUpdate.newCameraPosition(_home));
    //Navigator.of(context).pop(false);
    //_loadMapDialog();
  }
}
