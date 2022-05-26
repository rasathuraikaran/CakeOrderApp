import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'cake.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class Cakes with ChangeNotifier {
  List<Cake> _cakeList = [
    // Cake(
    //     id: 'm1',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1549572189-dddb1adf739b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=637&q=80',
    //     title: "ChockLate Cakes",
    //     hotelName: "Jathusan Hotel",
    //     rating: 3.5,
    //     ratecount: 94,
    //     amount: 2800,
    //     details: [
    //       'Non Veg',
    //       'High Sugar',
    //       "Colorings Added",
    //       "4 or 5 peoples enough"
    //     ],
    //     categories: [
    //       'c1',
    //       'c3'
    //     ]),
    // Cake(
    //     id: 'm2',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1610850775639-d47c1c81040c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    //     title: 'Chocklate Cakes',
    //     hotelName: 'Mohanram hotel',
    //     rating: 5,
    //     ratecount: 700,
    //     amount: 3500,
    //     details: [
    //       'Non Veg',
    //       'High Sugar',
    //       "Colorings Added",
    //       "4 or 5 peoples enough"
    //     ],
    //     categories: [
    //       'c1'
    //     ]),
    // Cake(
    //     id: 'm3',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1611292995678-b5cbfa9b47c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=704&q=80',
    //     title: 'Choco',
    //     hotelName: 'Vinesh Hotel',
    //     rating: 4.5,
    //     ratecount: 102,
    //     amount: 1200,
    //     details: [
    //       'Non Veg',
    //       'High Sugar',
    //       "Colorings Added",
    //       "4 or 5 peoples enough"
    //     ],
    //     categories: [
    //       'c1'
    //     ]),
    // Cake(
    //     id: 'm4',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1568051243857-068aa3ea934d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    //     title: 'Vannila Cake',
    //     hotelName: 'VarathaRaja Cake',
    //     rating: 1.2,
    //     ratecount: 34,
    //     amount: 1222,
    //     details: [
    //       'Non Veg',
    //       'High Sugar',
    //       "Colorings Added",
    //       "4 or 5 peoples enough"
    //     ],
    //     categories: [
    //       'c6'
    //     ]),
    // Cake(
    //     id: 'm5',
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1574538860416-baadc5d4ec57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=633&q=80',
    //     title: 'Wedding Cakes',
    //     hotelName: 'Jetwing Hotel',
    //     rating: 3.4,
    //     ratecount: 102,
    //     amount: 15000,
    //     details: [
    //       'Non Veg',
    //       'High Sugar',
    //       "Colorings Added",
    //       "4 or 5 peoples enough"
    //     ],
    //     categories: [
    //       'c4'
    //     ])
  ];
  //static const String firebaseAppUrl = 'Copy Past Your own firebase app url';

  String? authToken;
  String? userId;
  void updateData(String tokendata, List<Cake> lists) {
    _cakeList = lists;

    authToken = tokendata;
    notifyListeners();
  }

  // Cakes(this._cakeList, [this.authToken, this.userId]);

  Future<void> addCake(Cake cake) async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/cakelist.json', {'auth': '$authToken'});
    try {
      final response = await http.post(url,
          body: json.encode({
            'imageUrl': cake.imageUrl,
            'title': cake.title,
            'hotelName': cake.hotelName,
            'rating': cake.rating,
            'amount': cake.amount,
            'details': cake.details,
            'categories': cake.categories
          }));
      final newCake = Cake(
          id: json.decode(response.body)['name'],
          imageUrl: cake.imageUrl,
          title: cake.title,
          hotelName: cake.hotelName,
          rating: cake.rating,
          amount: cake.amount,
          details: cake.details,
          categories: cake.categories);
      _cakeList.add(newCake);
    } catch (error) {
      print(error);

      throw error;
    }

    notifyListeners();
  }

  List<Cake> get cakeList {
    return [..._cakeList];
  }

  Cake findById(String id) {
    return _cakeList.firstWhere((prod) => prod.id == id);
  }

  Future<void> removeItem(String id) async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/cakelist/$id.json', {'auth': '$authToken'});
    final existingCakeIndex = _cakeList.indexWhere((cak) => cak.id == id);
    Cake? existingCake = _cakeList[existingCakeIndex];
    _cakeList.removeAt(existingCakeIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode > 400) {
      _cakeList.insert(existingCakeIndex, existingCake);
      notifyListeners();
      throw HttpException("We cant delete");
    }
    existingCake = null;
  }

  Future<void> fetchandSetProduct() async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/cakelist.json', {'auth': '$authToken'});
    try {
      final response = await http.get(url);
      print(" ");
      // print(url);
      print(response.statusCode);

      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if (extractData == null) {
        return;
      }
      final List<Cake> loadedProduct = [];
      //print(extractData);
      extractData.forEach((cakeId, cakeData) {
        loadedProduct.add(Cake(
            id: cakeId,
            imageUrl: cakeData['imageUrl'].toString(),
            title: cakeData['title'],
            hotelName: cakeData['hotelName'],
            rating: cakeData['rating'],
            amount: cakeData['amount'],
            details: cakeData['details'],
            categories: cakeData['categories'] as List<dynamic>));
      });

      //   print(loadedProduct[0].imageUrl);
      _cakeList = loadedProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      print("karan check cakes rellay error");
    }
  }

  Future<void> updateCake(String id, Cake newcake) async {
    final cakIndex = _cakeList.indexWhere((cak) => cak.id == id);
    if (cakIndex >= 0) {
      final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
          '/cakelist/$id.json', {'auth': '$authToken'});
      http.patch(url,
          body: json.encode({
            'imageUrl': newcake.imageUrl,
            'title': newcake.title,
            'hotelName': newcake.hotelName,
            'rating': newcake.rating,
            'amount': newcake.amount,
            'details': newcake.details,
            'categories': newcake.categories
          }));
      _cakeList[cakIndex] = newcake;
      notifyListeners();
    } else {
      print("....");
    }
  }
}
