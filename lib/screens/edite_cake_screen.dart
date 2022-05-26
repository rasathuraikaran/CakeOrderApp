import 'package:cake/providers/cake.dart';
import 'package:cake/providers/cakes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCakeScreen extends StatefulWidget {
  static const routeName = '/edit-cake';

  @override
  _EditCakeScreenState createState() => _EditCakeScreenState();
}

class _EditCakeScreenState extends State<EditCakeScreen> {
  final _imageUrl = TextEditingController();
  final _priceFocusNode = FocusNode();
  final _detailsFocusNode = FocusNode();
  final _catergoriesFocusNode = FocusNode();
  final _ratingFocusNode = FocusNode();
  final _hotelFocusNode = FocusNode();
  // final _imageUrl = TextEditingController();
  final _imageurlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editeCake = Cake(
      id: '',
      imageUrl: '',
      title: '',
      hotelName: '',
      rating: 0.0,
      amount: 0,
      details: '',
      categories: []);
  var isInit = true;

  var _initValues = {
    'imageUrl': '',
    'title': '',
    'hotelName': '',
    'rating': 0.0,
    'amount': '',
    'details': '',
    'categories': ''
  };
  @override
  void initState() {
    _imageurlFocusNode.addListener(_updateImageUrl);
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final cakeId = ModalRoute.of(context)!.settings.arguments as String?;
      if (cakeId != null) {
        _editeCake =
            Provider.of<Cakes>(context, listen: false).findById(cakeId);
        _initValues = {
          'imageUrl': '',
          'title': _editeCake.title,
          'hotelName': _editeCake.hotelName,
          'rating': _editeCake.rating.toString(),
          'amount': _editeCake.amount.toString(),
          'details': _editeCake.details,
          'categories': _editeCake.categories
        };
        _imageUrl.text = _editeCake.imageUrl;
      }
    }
    isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void dispose() {
    _imageurlFocusNode.removeListener(_updateImageUrl);
    _imageurlFocusNode.dispose();
    _priceFocusNode.dispose();
    _detailsFocusNode.dispose();
    _catergoriesFocusNode.dispose();
    _imageUrl.dispose();
    _ratingFocusNode.dispose();
    _hotelFocusNode.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageurlFocusNode.hasFocus) {
      if (!_imageUrl.text.startsWith("https")) {
        return;
      }

      setState(() {});
    }
  }

  void _saveform() async {
    final isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }

    _form.currentState!.save();
    if (_editeCake.id != '') {
      await Provider.of<Cakes>(context, listen: false)
          .updateCake(_editeCake.id, _editeCake);
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Cakes>(context, listen: false).addCake(_editeCake);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("An Error Ocuures!"),
                  content: Text("Something wents Wrong"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("OKaY"))
                  ],
                ));
      } finally {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Your Cakes"),
          actions: [IconButton(onPressed: _saveform, icon: Icon(Icons.save))],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'].toString(),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_hotelFocusNode);
                  },
                  decoration: InputDecoration(labelText: " Title"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Provide the title";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editeCake = Cake(
                        id: _editeCake.id,
                        imageUrl: _editeCake.imageUrl,
                        title: value.toString(),
                        hotelName: _editeCake.hotelName,
                        rating: _editeCake.rating,
                        amount: _editeCake.amount,
                        details: _editeCake.details,
                        categories: _editeCake.categories);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['hotelName'].toString(),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  decoration: InputDecoration(labelText: " Hotel Name"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Provide the HotelName";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editeCake = Cake(
                        id: _editeCake.id,
                        imageUrl: _editeCake.imageUrl,
                        title: _editeCake.title,
                        hotelName: value.toString(),
                        rating: _editeCake.rating,
                        amount: _editeCake.amount,
                        details: _editeCake.details,
                        categories: _editeCake.categories);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['amount'].toString(),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_detailsFocusNode);
                  },
                  decoration: InputDecoration(labelText: "Amount"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter the Valid Price";
                    }
                    if (int.tryParse(value) == null) {
                      return "Enter the  price";
                    }
                    if (int.tryParse(value)! <= 0) {
                      return "Enter the valid price greater than zerpo";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editeCake = Cake(
                        id: _editeCake.id,
                        imageUrl: _editeCake.imageUrl,
                        title: _editeCake.title,
                        hotelName: _editeCake.hotelName,
                        rating: _editeCake.rating,
                        amount: int.parse(value!),
                        details: _editeCake.details,
                        categories: _editeCake.categories);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['rating'].toString(),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_detailsFocusNode);
                  },
                  decoration: InputDecoration(labelText: "Rating"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter the Valid rating";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter the  rating";
                    }
                    if (double.tryParse(value)! <= 0) {
                      return "Enter the valid rating greater than zero";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editeCake = Cake(
                        id: _editeCake.id,
                        imageUrl: _editeCake.imageUrl,
                        title: _editeCake.title,
                        hotelName: _editeCake.hotelName,
                        rating: double.parse(value!),
                        amount: _editeCake.amount,
                        details: _editeCake.details,
                        categories: _editeCake.categories);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['details'].toString(),
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_catergoriesFocusNode);
                  // },
                  decoration: InputDecoration(labelText: "Details"),
                  //  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter the describtions";
                    }
                    if (value.length < 10) {
                      return "Please enter the describtion atlese min 10 characters";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (value) {
                    _editeCake = Cake(
                        id: _editeCake.id,
                        imageUrl: _editeCake.imageUrl,
                        title: _editeCake.title,
                        hotelName: _editeCake.hotelName,
                        rating: _editeCake.rating,
                        amount: _editeCake.amount,
                        details: value.toString(),
                        categories: _editeCake.categories);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['categories'].toString(),
                  decoration: InputDecoration(labelText: " categories"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plese Enter the catergories";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editeCake = Cake(
                      id: _editeCake.id,
                      imageUrl: _editeCake.imageUrl,
                      title: _editeCake.title,
                      hotelName: _editeCake.hotelName,
                      rating: _editeCake.rating,
                      amount: _editeCake.amount,
                      details: _editeCake.details,
                      categories: value.toString().toLowerCase().split(','),
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: _imageUrl.text.isEmpty
                          ? Text("Enter UrL")
                          : FittedBox(
                              child: Image.network(_imageUrl.text),
                              fit: BoxFit.cover,
                            ),
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.green)),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageUrl'].toString(),
                        decoration: InputDecoration(labelText: "Image URL"),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageurlFocusNode,

                        controller: _imageUrl,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Plesezz Enter the URL adress";
                          }

                          if (!value.startsWith("https")) {
                            return "Enter the Val   id URL adress";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editeCake = Cake(
                              id: _editeCake.id,
                              imageUrl: value.toString(),
                              title: _editeCake.title,
                              hotelName: _editeCake.hotelName,
                              rating: _editeCake.rating,
                              amount: _editeCake.amount,
                              details: _editeCake.details,
                              categories: _editeCake.categories);
                        },
                        onFieldSubmitted: (_) {
                          {
                            _saveform();
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
