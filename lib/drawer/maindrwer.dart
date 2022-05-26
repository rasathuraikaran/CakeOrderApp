import 'package:cake/cake_types.dart';
import 'package:cake/providers/auth.dart';

import 'package:cake/providers/orderitem.dart';
import 'package:cake/screens/auth_screen.dart';
import 'package:cake/screens/homescreen.dart';
import 'package:cake/screens/orderscreen.dart';
import 'package:cake/screens/user_cake_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.brown, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                'CakeDA',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Powered By',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Center(
              child: Text(
                'Jaffna  Devolper',
                style: TextStyle(fontSize: 20, color: Colors.brown),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Container(
            //   color: Colors.white,
            //   height: 100,
            //   width: double.infinity,
            //   padding: EdgeInsets.all(10),
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     "Cake Ready!!!",
            //     style: TextStyle(
            //         fontWeight: FontWeight.w900,
            //         fontSize: 32,
            //         color: Theme.of(context).primaryColor),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // CircleAvatar(
            //   radius: 40,
            //   backgroundImage: NetworkImage(user.photoURL!),
            // ),
            SizedBox(
              height: 20,
            ),

            listTilewidget('Home', Icons.home, () {
              Navigator.of(context).push(MaterialPageRoute(builder: (Context) {
                return HomeScreen();
              }));
            }),
            listTilewidget('Catergories', Icons.category, () {
              Navigator.of(context).push(MaterialPageRoute(builder: (Context) {
                return CakeTypes();
              }));
            }),

            listTilewidget('Orders', Icons.payments, () {
              Navigator.of(context)
                  .pushReplacementNamed(OrederScreen.routeName);
            }),
            Provider.of<Auth>(context, listen: false).userid ==
                        "Pyp0gdD2QRhe6ElgKg0GfVvbLhr1" ||
                    Provider.of<Auth>(context, listen: false).userid ==
                        "o0wY792o4Wf0IUJbskKZYdK8Wms2"
                ? listTilewidget('ManageCakes', Icons.edit, () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (Context) {
                      return UserProducts();
                    }));
                  })
                : SizedBox(
                    height: 20,
                  ),
            listTilewidget('Logout', Icons.exit_to_app, () {
              Navigator.of(context).pop();

              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/splash", ModalRoute.withName("/home"));

              // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //   return AuthScreen();
              // }));
            }),
          ],
        ),
      ),
    );
  }

  Widget listTilewidget(
      String title, IconData icondata, VoidCallback taphandler) {
    return ListTile(
      leading: Icon(
        icondata,
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontFamily: 'RobotoCondensed'),
      ),
      onTap: taphandler,
    );
  }
}
