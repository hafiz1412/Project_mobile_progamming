import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_aduan_final/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartscreen.dart';
import 'paymenthistoryscreen.dart';

class EaduanShop extends StatefulWidget {
  final User user;

  const EaduanShop({Key key, this.user}) : super(key: key);

  @override
  _EaduanShopState createState() => _EaduanShopState();
}

class _EaduanShopState extends State<EaduanShop> {
  List productdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  String titlecenter = "Loading products...";
  String server = "http://shabab-it.com/e_aduan_final";

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadCartQuantity();
    // if (widget.user.email == "admin@grocery.com") {
    //   _isadmin = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromRGBO(52, 61, 65, 5),
      drawer: mainDrawer(context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellowAccent,
        title: Text(
          'E-ADUAN SHOP',
          style: TextStyle(
            color: Colors.black,fontFamily: 'Roadtrack',fontSize: 40
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Colors.yellowAccent),
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: _prdController,
                    cursorColor: Colors.yellowAccent,
                    cursorRadius: Radius.circular(16),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.yellow),
                        ),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Search item do you want',
                        labelStyle: TextStyle(color: Colors.yellowAccent),
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.yellowAccent,
                        )),
                  )
                ])),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 100,
                      height: 50,
                      child: RaisedButton(
                        splashColor: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellowAccent),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text('Search',
                            style: TextStyle(
                                color: Colors.yellowAccent, fontSize: 16)),
                        color: Colors.black,
                        elevation: 10,
                        onPressed: () => {_sortItembyName(_prdController.text)},
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(curtype,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent)),
            productdata == null
                ? Flexible(
                    child: Container(
                        child: Center(
                            child: Text(
                    titlecenter,
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ))))
                : Expanded(
                    child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: (screenWidth / screenHeight) / 0.8,
                        children: List.generate(productdata.length, (index) {
                          return Container(
                              child: Card(
                                  color: Colors.yellowAccent[700],
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: screenHeight / 2,
                                          width: screenWidth / 1.3,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: server +
                                                "/productimage/${productdata[index]['id']}.jpg",
                                            placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),
                                          ),
                                        ),
                                        Text(productdata[index]['name'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        Text(
                                          "RM " + productdata[index]['price'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Quantity available:" +
                                              productdata[index]['quantity'],
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Weight:" +
                                              productdata[index]['weigth'] +
                                              " gram",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          minWidth: 100,
                                          height: 30,
                                          child: Text(
                                            'Add to Cart',
                                          ),
                                          splashColor: Colors.yellowAccent,
                                          color: Colors.black,
                                          textColor: Colors.yellowAccent,
                                          elevation: 10,
                                          onPressed: () =>
                                              _addtocartdialog(index),
                                        ),
                                      ],
                                    ),
                                  )));
                        })))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        splashColor: Colors.black,
        onPressed: () async {
          if (widget.user.quantity == "0") {
            Toast.show("Cart empty", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            return;
          } else {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CartScreen(
                          user: widget.user,
                        )));
            _loadData();
            _loadCartQuantity();
          }
        },
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.yellowAccent,
        ),
        label: Text(cartquantity, style: TextStyle(color: Colors.yellowAccent)),
      ),
    );
  }

  void _loadData() async {
    String urlLoadJobs = server + "/php/load_products.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        cartquantity = "0";
        titlecenter = "No product found";
        setState(() {
          productdata = null;
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          productdata = extractdata["products"];
          cartquantity = widget.user.quantity;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadCartQuantity() async {
    String urlLoadJobs = server + "/php/load_cartquantity.php";
    await http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
      } else {
        widget.user.quantity = res.body;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Widget mainDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.yellowAccent,
        child: ListView(
          children: <Widget>[
            ListTile(
                title: Text(
                  "Payment History",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PaymentHistoryScreen(
                                    user: widget.user,
                                  ))),
                    }),
          ],
        ),
      ),
    );
  }

  _addtocartdialog(int index) {
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              backgroundColor: Colors.yellowAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + productdata[index]['name'] + " to Cart?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Select quantity of product",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Colors.yellow[900],
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity <
                                    (int.parse(productdata[index]['quantity']) -
                                        2)) {
                                  quantity++;
                                } else {
                                  Toast.show("Quantity not available", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.CENTER);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Colors.yellow[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      _addtoCart(index);
                    },
                    child: Text(
                      "Yes",
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
            );
          });
        });
  }

  void _addtoCart(int index) {
    try {
      int cquantity = int.parse(productdata[index]["quantity"]);
      print(cquantity);
      print(productdata[index]["id"]);
      print(widget.user.email);
      if (cquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs = server + "/php/insert_cart.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "proid": productdata[index]["id"],
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            Toast.show("Failed add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            pr.hide();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              cartquantity = respond[1];
              widget.user.quantity = cartquantity;
            });
            Toast.show("Success add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          }
          pr.hide();
        }).catchError((err) {
          print(err);
          pr.hide();
        });
        pr.hide();
      } else {
        Toast.show("Out of stock", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    } catch (e) {
      Toast.show("Failed add to cart", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  void _sortItembyName(String prname) {
    try {
      print(prname);
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs = server + "/php/load_products.php";
      http
          .post(urlLoadJobs, body: {
            "name": prname.toString(),
          })
          .timeout(const Duration(seconds: 4))
          .then((res) {
            if (res.body == "nodata") {
              Toast.show("Product not found", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              pr.hide();
              setState(() {
                titlecenter = "No product found";
                curtype = "search for " + "'" + prname + "'";
                productdata = null;
              });
              FocusScope.of(context).requestFocus(new FocusNode());

              return;
            } else {
              setState(() {
                var extractdata = json.decode(res.body);
                productdata = extractdata["products"];
                FocusScope.of(context).requestFocus(new FocusNode());
                //curtype = prname;
                curtype = "search for " + "'" + prname + "'";
                pr.hide();
              });
            }
          })
          .catchError((err) {
            pr.hide();
          });
      pr.hide();
    } on TimeoutException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } on SocketException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  gotoCart() async {
    if (widget.user.quantity == "0") {
      Toast.show("Cart empty", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    } else {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
      _loadData();
      _loadCartQuantity();
    }
  }
}
