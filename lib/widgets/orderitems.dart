import 'package:cake/providers/orderitem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatelessWidget {
  final OrderItem order;
  OrderItems(this.order);
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.brown.shade100,
        margin: EdgeInsets.all(10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Cake Name  :" + order.title,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Receiver  Name  :" + order.fullName,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Ordered Date  :" +
                    DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Amount  :Rs " + order.amount.toString(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Receiver Arderess  :",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    order.Adress,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Received Date  :" + order.reciveDate,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contact Number  :" + order.phonenumber.toString(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Ordered Status  :",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  order.staus == "Ordered" || order.staus == "Approved"
                      ? Text(
                          order.staus,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        )
                      : Text(
                          order.staus,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  order.imageurl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }
}
