import 'dart:io';

import 'package:cake/providers/cakecatergories.dart';
import 'package:cake/providers/cakes.dart';
import 'package:cake/providers/catergorymodel.dart';
//import 'package:cake/providers/google.dart';

import 'package:cake/screens/cake_detail_screen.dart';
import 'package:cake/screens/cakecater_screen.dart';
import 'package:cake/drawer/maindrwer.dart';
import 'package:cake/screens/each_cakescreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _auth = FirebaseAuth.instance;
  var _isInit = true;
  @override
  void initState() {
    // print("hi");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Cakes>(context).fetchandSetProduct();
      Provider.of<CakesCatergories>(context).fetchandSetProduct();
    }

    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void selectedCakes(
    ctx,
    title,
    id,
    url,
  ) {
    // ignore: empty_statements
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return EachCakeTypes(title, id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    print("from home");
    // print(provider.idToken);
    //   final popularCake = Provider.of<PopularCakes>(context).popularList;
    final cakelist = Provider.of<Cakes>(context, listen: false).cakeList;
    final cakecatergoryList =
        Provider.of<CakesCatergories>(context, listen: false).cakeCatergoryList;
    List<String> bannerList = [];
    for (int i = 0; i < cakelist.length; i++) {
      bannerList.add(cakelist[i].imageUrl);
    }
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (Text(
                  "Deleiverd By",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.grey),
                )),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "CakeDA",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.green,
                        size: 40,
                      )
                    ],
                  ),
                )
              ],
            )),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              TitleWidget(context, "Catergories"),
              Container(
                height: 150, // height kodukkanum
                child: ListView.builder(
                    itemCount: cakecatergoryList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    //physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: CatergoryList(cakecatergoryList[index]),
                        onTap: () {
                          selectedCakes(
                              context,
                              cakecatergoryList[index].title,
                              cakecatergoryList[index].Ctype,
                              cakecatergoryList[index].imageUrl);
                        },
                      );
                    }),
              ),
              TitleWidget(context, "Populars"),
              for (int i = 0; i < bannerList.length; i++) ...{
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CakeDetailsScreen(
                            cakelist[i].id,
                            cakelist[i].title,
                            cakelist[i].imageUrl,
                            cakelist[i].amount);
                      }));
                    },
                    child: Card(
                      elevation: 0.8,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  spreadRadius: 5)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 225,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(bannerList[i]),
                                        fit: BoxFit.cover))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TitleWidget(context, cakelist[i].title),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(cakelist[i].rating.toString(),
                                      style: TextStyle(color: Colors.brown)),
                                  Spacer(),
                                  Icon(Icons.cake),
                                  Text(cakelist[i].hotelName,
                                      style: TextStyle(color: Colors.brown)),
                                  SizedBox(
                                    height: 10,
                                    width: 10,
                                  ),
                                  Text(" Rs." + cakelist[i].amount.toString(),
                                      style: TextStyle(color: Colors.brown))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 5,
                )
              }
            ],
          ),
        )),
      ),
    );
  }

  Text TitleWidget(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}

class CatergoryList extends StatelessWidget {
  final CakeCatergory catergorylist;
  CatergoryList(this.catergorylist);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.red.withOpacity(0.3),
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 5, bottom: 2, right: 5, left: 8),
            height: 100,
            width: 100,
            child: Image.network(
              catergorylist.imageUrl,
              fit: BoxFit.cover,
            )),
        Text(
          catergorylist.title,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
