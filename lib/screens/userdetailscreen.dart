import 'package:cake/providers/orderitem.dart';
import 'package:cake/screens/orderscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  String authToken;
  String title;
  int price;
  String id;
  String imageUrl;
  UserDetails(@required this.authToken, @required this.title,
      @required this.price, @required this.id, @required this.imageUrl);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  int currentStep = 0;
  bool isCompleted = false;
  final fname = TextEditingController();
  final lname = TextEditingController();
  final number = TextEditingController();
  DateTime adress = DateTime.now();
  final _form = GlobalKey<FormState>();
  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text("Details"),
            content: Column(
              children: [
                TextFormField(
                  controller: fname,
                  decoration: InputDecoration(labelText: "FullName"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: lname,
                  decoration: InputDecoration(
                      labelText: "Adress",
                      hintText: "choliyapuram centre\n choliyapuram \nJaffna"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text("Contact Details"),
            content: Column(
              children: [
                // TextFormField(
                //   controller: adress,
                //   decoration: InputDecoration(
                //       labelText: "Date that You want-கேக் பெற விரும்பும் தேதி"),
                // ),
                TextFormField(
                  key: _form,
                  keyboardType: TextInputType.number,
                  controller: number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(labelText: "Phone  Number"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter the Phone Number";
                    }
                    if (int.tryParse(value) == null) {
                      return "Enter the  Phone Number";
                    }
                    if (int.tryParse(value)! <= 0) {
                      return "Enter the valid Phone Number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                        elevation: 20,
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 5))
                              .then((pickedDate) {
                            if (pickedDate == null) {
                              return;
                            }
                            setState(() {
                              adress = pickedDate;
                            });
                          });
                        },
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          //alignment: Alignment.,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.brown, Colors.brown])),
                          child: Text(
                            "Select Date to recieved",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            isActive: currentStep >= 1),
        Step(
            title: Text("Complete"),
            content: Column(
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.brown.shade100,
                  child: ListTile(
                    trailing: Text(
                      fname.text,
                      style: TextStyle(fontSize: 20),
                    ),
                    title: Text(
                      "Ful Name",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.brown.shade100,
                  child: ListTile(
                    trailing: Text(
                      number.text,
                      style: TextStyle(fontSize: 20),
                    ),
                    title: Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.brown.shade100,
                  child: ListTile(
                    trailing: Text(
                      DateFormat.yMMMd().format(adress),
                      style: TextStyle(fontSize: 20),
                    ),
                    title: Text(
                      "Date that you recived",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.brown.shade100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Adress",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            lname.text,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            isActive: currentStep >= 2)
      ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.brown.shade100),
      home: Container(
        child: SafeArea(
          child: Scaffold(
              body: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: Colors.brown)),
            child: Stepper(
              onStepTapped: (step) => setState(() => currentStep = step),
              steps: getSteps(),
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepContinue: () async {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  setState(() {
                    isCompleted = true;
                  });
                  print("Completed");
                  //

                  await Provider.of<Orders>(context, listen: false).addOrder(
                      widget.id,
                      widget.price,
                      widget.title,
                      widget.imageUrl,
                      fname.text,
                      lname.text,
                      DateFormat.yMMMd().format(adress),
                      number.text);

                  setState(() {
                    isCompleted = true;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                        "Sucessfully added !!!\n \n Wait For your Confirmation Message\n"),
                    duration: Duration(seconds: 3),
                  ));
                  Navigator.of(context).pushReplacementNamed(
                    OrederScreen.routeName,
                  );
                  // send the Data To Server

                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
              controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onStepCancel,
                          child: Text("Back"),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onStepContinue,
                          child: Text(isLastStep ? "Confirm" : "Next"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
        ),
      ),
    );
  }
}
