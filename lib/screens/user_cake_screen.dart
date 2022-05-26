import 'package:cake/drawer/maindrwer.dart';
import 'package:cake/providers/cakes.dart';
import 'package:cake/screens/edite_cake_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cakeData = Provider.of<Cakes>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("UserCakes"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditCakeScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: cakeData.cakeList.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(cakeData.cakeList[index].imageUrl),
                      ),
                      title: Text(cakeData.cakeList[index].title),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      EditCakeScreen.routeName,
                                      arguments: cakeData.cakeList[index].id);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                              onPressed: () async {
                                await Provider.of<Cakes>(context, listen: false)
                                    .removeItem(cakeData.cakeList[index].id);
                              },
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
