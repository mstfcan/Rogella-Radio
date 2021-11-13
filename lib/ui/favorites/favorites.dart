import 'package:flutter/material.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:rogella_radio/ui/animations/page_anitmations.dart';
import 'package:rogella_radio/ui/categories/category_detail_item.dart';
import 'package:rogella_radio/ui/listen/listen_radio.dart';
import 'package:rogella_radio/utils/database_helper_two.dart';
import 'package:rogella_radio/utils/read_values.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  DatabaseHelperTwo dbHelperTwo = new DatabaseHelperTwo();
  List<MyRadio> _radioList;
  bool _loadingRadios = false;

  @override
  void initState() {
    super.initState();
    _radioList = new List<MyRadio>();
    getRadios();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Color(ReadValues.getColor("content_background")),
      ),
      child: _loadingRadios
          ? Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : _radioList.length == 0
              ? Align(
                  alignment: Alignment.center,
                  child: Text("There is no favorite radio yet."),
                )
              : ListView.builder(
                  itemCount: _radioList.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: ListenRadio(_radioList[index])))
                          .then((value){
                        getRadios();
                      }),
                      child: CategoryDetailItem(_radioList[index]))),
    );
  }

  void filterRadiosCountry(String country_code) {
    setState(() {
      if (country_code == "")
        getRadios();
      else
        _radioList =
            _radioList.where((x) => x.countrycode == country_code).toList();
    });
  }

  void getRadios() async {
    setState(() {
      _loadingRadios = true;
    });
    _radioList = (await dbHelperTwo.allFavorites())
        .map((mradio) => MyRadio.fromMap(mradio))
        .toList();
    setState(() {
      _loadingRadios = false;
    });
  }


}
