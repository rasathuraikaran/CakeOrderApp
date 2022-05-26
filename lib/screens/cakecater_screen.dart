import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cartscreen.dart';

class CakeCatergoryScreen extends StatelessWidget {
  String id;
  String title;
  String imageurl;
  String hostelName;
  String details;
  int price;
  CakeCatergoryScreen(
      @required this.id,
      @required this.title,
      @required this.imageurl,
      @required this.hostelName,
      @required this.details,
      @required this.price);
  selectitems(ctx, id, title, price, imageurl) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return CartScreen(id, title, price, imageurl);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Details',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              height: 180,
              width: 300,
              child: Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    details,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    strutStyle: StrutStyle(fontSize: 20),
                    style: TextStyle(color: Colors.brown, fontSize: 14),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              color: Colors.amber,
              child: FlatButton(
                  onPressed: () {
                    selectitems(context, id, title, price, imageurl);
                  },
                  child: Text(
                    "Order Now",
                    style: TextStyle(color: Colors.purple, fontSize: 22),
                  )),
            )
          ],
        ));
  }
}
