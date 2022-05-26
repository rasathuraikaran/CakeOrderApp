import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class OrderItem {
  final String id;
  final String title;
  final String imageurl;
  final int amount;
  final DateTime dateTime;
  final String reciveDate;
  final String staus;
  final String fullName;
  final String Adress;
  final String phonenumber;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.title,
      required this.imageurl,
      required this.dateTime,
      required this.Adress,
      required this.phonenumber,
      required this.fullName,
      required this.reciveDate,
      required this.staus});
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
  List<OrderItem> get order {
    return [..._order];
  }

  String? authToken;
  String? userId;

  void updateData(String tokendata, List<OrderItem> lists, String userid) {
    _order = lists;
    userId = userid;

    authToken = tokendata;
    notifyListeners();
  }

  Future<void> FetchAndDSetData() async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/orders/' + userId! + '.json', {'auth': '$authToken'});
    try {
      final response = await http.get(url);

      final List<OrderItem> loadedOrder = [];
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      ;

      print("null or illayo paaat");
      print(extractData);
      if (extractData == null) {
        return;
      }

      extractData.forEach((orderId, orderdata) {
        loadedOrder.add(OrderItem(
            Adress: orderdata['Adress'],
            fullName: orderdata['fullName'],
            phonenumber: orderdata['PhoneNumber'],
            reciveDate: orderdata['recieved-DateTime'],
            staus: orderdata['status'],
            id: orderId,
            amount: orderdata['amount'],
            title: orderdata['Title'],
            imageurl: orderdata['ImageUrl'],
            dateTime: DateTime.parse(
              orderdata['OrderedDateime'],
            )));
      });
      _order = loadedOrder.reversed.toList();
    } catch (error) {
      print(error);
      print("adei orders fetch appnu ppadala");
    }

    notifyListeners();
  }

  Future<void> addOrder(
    String id,
    int amount,
    String title,
    String imageurl,
    String lname,
    String fname,
    String adress,
    String number,
  ) async {
    final url = Uri.https('cakejaffna-default-rtdb.firebaseio.com',
        '/orders/' + userId! + '.json', {'auth': '$authToken'});

    final response = await http.post(url,
        body: json.encode({
          'id': id,
          'amount': amount,
          'Title': title,
          'ImageUrl': imageurl,
          'OrderedDateime': DateTime.now().toIso8601String(),
          'Adress': fname,
          'fullName': lname,
          'recieved-DateTime': adress,
          'PhoneNumber': number,
          'status': "Pending",
        }));

    _order.insert(
        0,
        OrderItem(
            Adress: fname,
            fullName: lname,
            phonenumber: number,
            staus: "Pending",
            reciveDate: adress,
            id: authToken.toString(),
            amount: amount,
            title: title,
            imageurl: imageurl,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
