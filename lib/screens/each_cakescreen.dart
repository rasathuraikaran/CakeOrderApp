import 'package:cake/providers/cakes.dart';
import 'package:cake/screens/cake_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class EachCakeTypes extends StatelessWidget {
  String title;
  String id;

  // double price;
  EachCakeTypes(
    this.title,
    this.id,
  );
  selectCakes(ctx, id, title, imageurl, price) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return CakeDetailsScreen(id, title, imageurl, price);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final cakelist = Provider.of<Cakes>(context, listen: false).cakeList;
    final cakes = cakelist.where((cak) {
      return cak.categories.contains(id);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return InkWell(
                onTap: () {
                  selectCakes(context, cakes[index].id, cakes[index].title,
                      cakes[index].imageUrl, cakes[index].amount);
                },
                child: Card(
                  elevation: 4,
                  child: Container(
                    margin: EdgeInsets.all(10),
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
                                    image: NetworkImage(cakes[index].imageUrl),
                                    fit: BoxFit.cover))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cakes[index].title),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(cakes[index].rating.toString(),
                                  style: TextStyle(color: Colors.brown)),
                              Spacer(),
                              Icon(Icons.cake),
                              Text(cakes[index].hotelName,
                                  style: TextStyle(color: Colors.brown)),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(" Rs." + cakes[index].amount.toString(),
                                  style: TextStyle(color: Colors.brown))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          },
          itemCount: cakes.length,
        ));
  }
}

// class Cakes {
//   final String id;

//   final String imageUrl;
//   final String title;

//   final String hotelName;
//   final double rating;
//   final double amount;
//   final double ratecount;
//   final List<String> details;
//   final List<String> categories;

//   const Cakes(
//       @required this.id,
//       @required this.imageUrl,
//       @required this.title,
//       @required this.hotelName,
//       @required this.rating,
//       @required this.ratecount,
//       @required this.amount,
//       @required this.details,
//       @required this.categories);
// }

// const cakeList = const [
//   Cakes(
//       'm1',
//       'https://images.unsplash.com/photo-1549572189-dddb1adf739b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=637&q=80',
//       "ChockLate Cakes",
//       "Jathusan Hotel",
//       3.5,
//       94,
//       2800,
//       ['Non Veg', 'High Sugar', "Colorings Added", "4 or 5 peoples enough"],
//       ['c1', 'c3']),
//   Cakes(
//       'm2',
//       'https://images.unsplash.com/photo-1610850775639-d47c1c81040c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
//       'Chocklate Cakes',
//       'Mohanram hotel',
//       5,
//       700,
//       3500,
//       ['Non Veg', 'High Sugar', "Colorings Added", "4 or 5 peoples enough"],
//       ['c1']),
//   Cakes(
//       'm3',
//       'https://images.unsplash.com/photo-1611292995678-b5cbfa9b47c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=704&q=80',
//       'Choco',
//       'Vinesh Hotel',
//       4.5,
//       102,
//       1200,
//       ['Non Veg', 'High Sugar', "Colorings Added", "4 or 5 peoples enough"],
//       ['c1']),
//   Cakes(
//       'm4',
//       'https://images.unsplash.com/photo-1568051243857-068aa3ea934d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
//       'Vannila Cake',
//       'VarathaRaja Cake',
//       1.2,
//       34,
//       1222,
//       ['Non Veg', 'High Sugar', "Colorings Added", "4 or 5 peoples enough"],
//       ['c6']),
//   Cakes(
//       'm5',
//       'https://images.unsplash.com/photo-1574538860416-baadc5d4ec57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=633&q=80',
//       'Wedding Cakes',
//       'Jetwing Hotel',
//       3.4,
//       102,
//       15000,
//       ['Non Veg', 'High Sugar', "Colorings Added", "4 or 5 peoples enough"],
//       ['c4'])
// ];
