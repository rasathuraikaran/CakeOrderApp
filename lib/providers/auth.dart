import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _idToken;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _idToken != null) {
      return _idToken;
    } else {
      return null;
    }
  }

  String? get userid {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB83SFCFvk9bXvhklk0ih0bBH7zLgsgX7U');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _idToken = responseData['idToken'];
      print(_idToken);
      print("exipiry date=>>>>>>" + _expiryDate.toString());
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print(_expiryDate);
      // _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _idToken,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }

    //  print(json.decode(response.body));
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final extractUserData = json.decode(prefs.getString("userData").toString());
    final expiryDate = DateTime.parse(extractUserData['expiryDate']);
    print(expiryDate);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _idToken = extractUserData['token'];
    _userId = extractUserData['userId'];
    _expiryDate = expiryDate;
    print("exipiry date=>>>>>> try autologin " + _expiryDate.toString());

    notifyListeners();
    // _autoLogout();
    return true;
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //   }
  //   final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }

  Future<void> loginup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB83SFCFvk9bXvhklk0ih0bBH7zLgsgX7U');

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _idToken = responseData['idToken'];
      // print(_idToken);

      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print("exipiry date=>>>>>>" + _expiryDate.toString());
      // _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _idToken,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }

    //  print(json.decode(response.body));
  }

  Future<void> logout() async {
    try {
      _idToken = null;
      _expiryDate = null;
      _userId = null;
      print("logout");
      print(token);
      if (_authTimer != null) {
        _authTimer!.cancel();
        _authTimer = null;
      }
      final prefs = await SharedPreferences.getInstance();
      //
      //
      //prefs.remove('userData');
      prefs.clear();
      notifyListeners();
      print("logout");
      print(token);
    } catch (error) {
      print("  karan inka ppar");
      print(error);
    }
  }
}
