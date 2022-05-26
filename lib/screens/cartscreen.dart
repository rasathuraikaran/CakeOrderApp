import 'package:cake/providers/orderitem.dart';
import 'package:cake/screens/orderscreen.dart';
import 'package:cake/screens/userdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final String id;
  final String title;
  //final String imageurl;
  final int price;
  final imageurl;

  CartScreen(this.id, this.title, this.price, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: (Text(
                      "Rs " + price.toString() + "  ",
                      style: TextStyle(color: Colors.white),
                    )),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButtton(
                      price: price, id: id, title: title, imageurl: imageurl)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButtton extends StatefulWidget {
  const OrderButtton({
    Key? key,
    required this.price,
    required this.id,
    required this.title,
    required this.imageurl,
  }) : super(key: key);

  final int price;
  final String id;
  final String title;
  final String imageurl;

  @override
  State<OrderButtton> createState() => _OrderButttonState();
}

class _OrderButttonState extends State<OrderButtton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.price <= 0 || _isLoading)
          ? null
          : () async {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text("Are You sure!"),
                        content: Text("Do you want to Order it."),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text("NO")),
                          FlatButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetails(
                                            Provider.of<Orders>(context,
                                                    listen: false)
                                                .authToken as String,
                                            widget.title,
                                            widget.price,
                                            widget.id,
                                            widget.imageurl)));
                                // await Provider.of<Orders>(context,
                                //         listen: false)
                                //     .addOrder(
                                //   widget.id,
                                //   widget.price,
                                //   widget.title,
                                //   widget.imageurl,
                                // );
                                setState(() {
                                  _isLoading = true;
                                });
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(SnackBar(
                                //   backgroundColor: Colors.green,
                                //   content: Text(
                                //       "Sucessfully added !!!\n \n Wait For your Confirmation Message\n"),
                                //   duration: Duration(seconds: 3),
                                // ));
                                // Navigator.of(context).pushReplacementNamed(
                                //   OrederScreen.routeName,
                                // );
                                //Navigator.of(ctx).pop(false);
                              },
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Text("Yes"))
                        ],
                      ));

              //
              //
            },
      child: Text(
        "Confirm Order",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
