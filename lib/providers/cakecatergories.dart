import 'dart:io';

import 'package:cake/providers/catergorymodel.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'cake.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class CakesCatergories with ChangeNotifier {
  List<CakeCatergory> _cakeCatergoryList = [];
  List<CakeCatergory> get cakeCatergoryList {
    return [..._cakeCatergoryList];
  }

  String? authToken;
  String? userId;

  void updateData(String tokendata, List<CakeCatergory> lists, String userid) {
    _cakeCatergoryList = lists;
    userId = userid;

    authToken = tokendata;
    print('Cake cater');
    print(authToken);
    notifyListeners();
  }

  Future<void> fetchandSetProduct() async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/cakeCatergoryList.json', {'auth': '$authToken'});

    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as Map<String, dynamic>;
      print("jason body");
      print(response.body);

      if (extractData == null) {
        return;
      }
      final List<CakeCatergory> loadedProduct = [];
      print("karan is boss");
      extractData.forEach((cakeId, cakeData) {
        loadedProduct.add(CakeCatergory(
            id: cakeId.toString(),
            imageUrl: cakeData['imageUrl'].toString(),
            title: cakeData['title'].toString(),
            Ctype: cakeData['ctype'].toString()));
      });

      print(loadedProduct[0].imageUrl);
      _cakeCatergoryList = loadedProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      print("karan check cakescatergory rellay error");
    }
  }

  Future<void> addCake(CakeCatergory cake) async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/cakeCatergoryList.json', {'auth': '$authToken'});
    try {
      final response = await http.post(url,
          body: json.encode({
            'imageUrl': cake.imageUrl,
            'title': cake.title,
            'ctype': cake.Ctype,
          }));
      final newCake = CakeCatergory(
          id: json.decode(response.body)['name'],
          imageUrl: cake.imageUrl,
          title: cake.title,
          Ctype: cake.Ctype);
      _cakeCatergoryList.add(newCake);
    } catch (error) {
      print(error);

      throw error;
    }

    notifyListeners();
  }
}
