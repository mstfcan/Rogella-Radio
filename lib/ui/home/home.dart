import 'package:flutter/material.dart';
import 'package:rogella_radio/ui/categories/categories.dart';
import 'package:rogella_radio/ui/countries/countries.dart';
import 'package:rogella_radio/ui/favorites/favorites.dart';
import 'package:rogella_radio/ui/home/bottom_navigation.dart';
import 'package:rogella_radio/ui/search/search.dart';
import 'package:rogella_radio/utils/read_values.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;

@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(changePage, currentPage),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 35, bottom: 40),
            color: Color(ReadValues.getColor("dark_color")),
            child: Text(
              "Rogella Radio",
              style:
                  TextStyle(fontSize:20,color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: showPage(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Color(ReadValues.getColor("content_background")),
            ),
          )
        ],
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget showPage() {
    switch (currentPage) {
      case 0:
        return Categories();
      case 1:
        return Search();
      case 2:
        return Favorites();
      case 3:
        return Countries();
      default:
        return Categories();
    }
  }
}
