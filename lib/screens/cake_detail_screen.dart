import 'package:cake/providers/cakes.dart';
import 'package:cake/providers/orderitem.dart';
import 'package:cake/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'each_cakescreen.dart';

class CakeDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  selectitems(ctx, id, title, price) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return CartScreen(id, title, price, imageUrl);
    }));
  }

  CakeDetailsScreen(this.id, this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //final cakeId = ModalRoute.of(context)!.settings.arguments as String;
    final cakelist = Provider.of<Cakes>(context, listen: false).cakeList;

    final selectedCakes = cakelist.firstWhere((cakes) => cakes.id == id);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(title: Text(title)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: deviceSize.height * 0.70,
                  width: double.infinity,
                  child: Image.network(
                    selectedCakes.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: deviceSize.height * 0.73,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          stops: [0.6, 0.95],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.white])),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        selectedCakes.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Text("Rs." + selectedCakes.amount.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Text(
                selectedCakes.details,
                // textScaleFactor: 1.2,
                // softWrap: true,
                textAlign: TextAlign.start,
                //  strutStyle: StrutStyle(fontSize: 20),
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                color: Colors.brown,
                child: FlatButton(
                    onPressed: () {
                      selectitems(context, selectedCakes.id,
                          selectedCakes.title, selectedCakes.amount);
                      // Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    )),
              )
            ],
          )),
    );
  }
}
