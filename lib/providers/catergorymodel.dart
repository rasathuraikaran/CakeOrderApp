import 'package:flutter/foundation.dart';

class CakeCatergory with ChangeNotifier {
  final String id;

  final String Ctype;

  final String imageUrl;
  final String title;

  CakeCatergory({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.Ctype,
  });
}
