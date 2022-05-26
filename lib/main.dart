import 'package:cake/cake_types.dart';
import 'package:cake/providers/auth.dart';
import 'package:cake/providers/cakecatergories.dart';
import 'package:cake/providers/cakes.dart';
//import 'package:cake/providers/google.dart';
import 'package:cake/providers/orderitem.dart';
import 'package:cake/screens/auth_screen.dart';
import 'package:cake/screens/cakecater_screen.dart';
import 'package:cake/screens/cartscreen.dart';
import 'package:cake/screens/edite_cake_screen.dart';
import 'package:cake/screens/homescreen.dart';
//import 'package:cake/screens/newauth.dart';

import 'package:cake/screens/orderscreen.dart';
import 'package:cake/screens/splashscreen.dart';
import 'package:cake/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//qzizK1ngGhWNPgjJLmyqwLPzAzC2

main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    // Firebase.auth().currentUser.getIdToken(/* forceRefresh */ true);

//     try  {
//    final result = await GoogleSignInProvider().googleLogin();
//    final ggAuth = await result.authentication;
//    print(ggAuth.idToken);
//    print(ggAuth.accessToken);
// } catch (error) {
//   print(error);
// }
    // GoogleSignInProvider().googleLogin().then((result) {
    //   result.authentication.then((googleKey) {
    //     print(googleKey.accessToken);
    //     print(googleKey.idToken);
    //     //print(GoogleSignInProvider().currentUser.displayName);
    //   }).catchError((err) {
    //     print('inner error');
    //   });
    // }).catchError((err) {
    //   print('error occured');
    // });

    // String x =await user.getIdToken();

    //print(x);
    // print(GoogleSignInProvider().idToken);\

    print("chdikkisianxnasosm");

    return MultiProvider(
      providers: [
        /// ChangeNotifierProvider.value(value: GoogleSignInProvider()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Cakes>(
          create: (ctx) => Cakes(),
          update: (ctx, auth, cakes) => cakes!
            ..updateData(
                auth.token.toString(), cakes == null ? [] : cakes.cakeList),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, orde) => orde!
            ..updateData(
                auth.token.toString(),
                // ignore: unnecessary_null_comparison
                orde == null ? [] : orde.order,
                auth.userid.toString()),
        ),
        ChangeNotifierProxyProvider<Auth, CakesCatergories>(
          create: (ctx) => CakesCatergories(),
          update: (ctx, auth, cakes) => cakes!
            ..updateData(
                auth.token.toString(),
                cakes == null ? [] : cakes.cakeCatergoryList,
                auth.userid.toString()),
        )
      ],
      // print();
      child: MaterialApp(
        debugShowMaterialGrid: false,
        home: SplashScreen(),
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.brown,
            accentColor: Colors.white,
            canvasColor: Color.fromRGBO(225, 224, 220, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                //body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                // body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                subtitle1:
                    TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20))),
        title: 'CakeDA',
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.routeName: (ctx) => SplashScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          OrederScreen.routeName: (ctx) => OrederScreen(),
          // CartScreen.routeName:(ctx)=>CartScreen()  ,
          EditCakeScreen.routeName: (ctx) => EditCakeScreen(),
        },
      ),
    );
  }
}
