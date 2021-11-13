import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {

  Function _changePage;
  int _currentPage;

  NavigationBar(this._changePage, this._currentPage);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: _changePage,
      type: BottomNavigationBarType.shifting,
      fixedColor: Colors.red,
      unselectedItemColor: Color(0xFF333333),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assistant_photo),
            label: ''
        ),
      ],
    );
  }


}
