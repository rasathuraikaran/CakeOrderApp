import 'package:cake/providers/cakecatergories.dart';
import 'package:cake/providers/cakes.dart';
import 'package:cake/screens/each_cakescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CakeTypes extends StatefulWidget {
  @override
  State<CakeTypes> createState() => _CakeTypesState();
}

class _CakeTypesState extends State<CakeTypes> {
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
    final cakecatergoryList =
        Provider.of<CakesCatergories>(context, listen: false).cakeCatergoryList;
    return Scaffold(
        appBar: AppBar(
          title: Text("CakeDA"),
        ),
        body: GridView(
          padding: EdgeInsets.all(15),
          children: cakecatergoryList.map((catdata) {
            return InkWell(
              onTap: () {
                selectedCakes(
                  context,
                  catdata.title,
                  catdata.Ctype,
                  catdata.imageUrl,
                );
              },
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(catdata.imageUrl),
                          fit: BoxFit.cover),
                      // gradient: LinearGradient(colors: [
                      //   catdata.color.withOpacity(0.7),
                      //   catdata.color
                      // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(15)),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      catdata.title,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ]),
            );
          }).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40),
        ));
  }
}

class TypesOfCaKes {
  final String id;
  final String title;
  final Color color;
  final String imageUrl;

  const TypesOfCaKes(
      {required this.id,
      required this.title,
      required this.color,
      required this.imageUrl});
}

// ignore: unnecessary_const
const TYPES = const [
  TypesOfCaKes(
      id: 'c1',
      title: 'Chocklate Cakes',
      color: Colors.purple,
      imageUrl:
          'https://images.unsplash.com/photo-1605807646983-377bc5a76493?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=924&q=80'),
  TypesOfCaKes(
      id: 'c2',
      title: 'Fruits Cakes',
      color: Colors.red,
      imageUrl:
          'https://images.unsplash.com/photo-1593424731252-a846f98af7e6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
  TypesOfCaKes(
      id: 'c3',
      title: 'Black Forest',
      color: Colors.greenAccent,
      imageUrl:
          'https://images.unsplash.com/photo-1606890737304-57a1ca8a5b62?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=734&q=80'),
  TypesOfCaKes(
      id: 'c4',
      title: 'Wedding Cakes',
      color: Colors.lightBlue,
      imageUrl:
          'https://images.unsplash.com/photo-1616690710400-a16d146927c5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
  TypesOfCaKes(
      id: "c5",
      title: 'Butter Scotch Cakes',
      color: Colors.pink,
      imageUrl:
          'https://images.unsplash.com/photo-1564988209213-c0de88d3c8ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1895&q=80'),
  TypesOfCaKes(
      id: "c6",
      title: 'Vennila',
      color: Colors.yellowAccent,
      imageUrl:
          'https://images.unsplash.com/photo-1596567836640-3c13eb102106?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1070&q=80'),
  TypesOfCaKes(
      id: "c7",
      title: 'Red Velvet',
      color: Colors.deepOrange,
      imageUrl:
          'https://images.unsplash.com/photo-1614707269211-474b2510b3ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'),
  TypesOfCaKes(
      id: "c8",
      title: 'PineApple Cakes',
      color: Colors.orangeAccent,
      imageUrl:
          'https://images.unsplash.com/photo-1584531597544-7ba9b4eb5494?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
  TypesOfCaKes(
      id: "c9",
      title: 'Buffler Cakes',
      color: Colors.blue,
      imageUrl:
          'https://images.unsplash.com/photo-1571115177098-24ec42ed204d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'),
  TypesOfCaKes(
      id: "c10",
      title: 'Other cakes',
      color: Colors.deepPurpleAccent,
      imageUrl:
          'https://images.unsplash.com/photo-1581636625141-a0f07e1ce6fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'),
];
