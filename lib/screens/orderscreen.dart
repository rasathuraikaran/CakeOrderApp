import 'package:cake/drawer/maindrwer.dart';
import 'package:cake/providers/orderitem.dart';
import 'package:cake/screens/homescreen.dart';
import 'package:cake/widgets/orderitems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrederScreen extends StatefulWidget {
  const OrederScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  State<OrederScreen> createState() => _OrederScreenState();
}

class _OrederScreenState extends State<OrederScreen> {
  Future? _orderFuture;
  Future obtainorderFuture() {
    return Provider.of<Orders>(context, listen: false).FetchAndDSetData();
  }

  @override
  void initState() {
    _orderFuture = obtainorderFuture();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderDdata = Provider.of<Orders>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Your Orders"),
          ),
          drawer: MainDrawer(),
          body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).FetchAndDSetData(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error != null) {
                  //do error handling
                  return Center(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, orderDdata, child) => ListView.builder(
                            itemBuilder: (ctx, i) =>
                                OrderItems(orderDdata.order[i]),
                            itemCount: orderDdata.order.length,
                          ));
                }
              }
            },
          )),
    );
  }
}
