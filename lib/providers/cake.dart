import 'package:flutter/foundation.dart';

class Cake with ChangeNotifier {
  final String id;

  final String imageUrl;
  final String title;

  final String hotelName;
  final double rating;
  final int amount;

  final String details;
  final List<dynamic> categories;

  Cake(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.hotelName,
      required this.rating,
      required this.amount,
      required this.details,
      required this.categories});
}
