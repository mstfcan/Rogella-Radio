import 'package:flutter/material.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:rogella_radio/ui/animations/page_anitmations.dart';
import 'package:rogella_radio/ui/categories/category_detail_item.dart';
import 'package:rogella_radio/ui/categories/category_top_header.dart';
import 'package:rogella_radio/ui/listen/listen_radio.dart';
import 'package:rogella_radio/utils/database_helper.dart';
import 'package:rogella_radio/utils/read_values.dart';

class CountryDetail extends StatefulWidget {
  String _country_code, _country_name;

  CountryDetail(this._country_code, this._country_name);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {

  DatabaseHelper dbHelper = new DatabaseHelper();
  bool _loadingRadios = false;
  List<MyRadio> _radioList;

  @override
  void initState() {
    super.initState();
    _radioList = new List<MyRadio>();
    getRadios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              height: 120,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 30),
              color: Color(ReadValues.getColor("dark_color")),
              child: Column(
                children: [
                  CategoryTopHeader(widget._country_name),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                : ListView.builder(
                    itemCount: _radioList.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            SlideRightRoute(
                                page: ListenRadio(_radioList[index]))),
                        child: CategoryDetailItem(_radioList[index]))),
          )
        ],
      ),
    );
  }

  void getRadios() async {
    setState(() {
      _loadingRadios = true;
    });
    _radioList = (await dbHelper.getCountryRadios(widget._country_code))
        .map((mradio) => MyRadio.fromMap(mradio))
        .toList();
    setState(() {
      _loadingRadios = false;
    });
  }
}
