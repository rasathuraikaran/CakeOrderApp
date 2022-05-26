import 'package:cake/cake_types.dart';
import 'package:cake/screens/homescreen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [HomeScreen(), CakeTypes()];
  int selectPageIndex = 0;
  void selectPages(int index) {
    setState(() {
      selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectPageIndex,
          onTap: selectPages,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.brown,
                icon: Icon(Icons.home),
                title: Text("Home")),
            BottomNavigationBarItem(
                backgroundColor: Colors.brown,
                icon: Icon(Icons.category),
                title: Text("Catergories"))
          ]),
    );
  }
}
