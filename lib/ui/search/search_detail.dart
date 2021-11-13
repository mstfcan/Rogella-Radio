import 'package:flutter/material.dart';
import 'package:rogella_radio/models/country.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:rogella_radio/ui/animations/page_anitmations.dart';
import 'package:rogella_radio/ui/categories/category_detail_item.dart';
import 'package:rogella_radio/ui/categories/category_top_header.dart';
import 'package:rogella_radio/ui/listen/listen_radio.dart';
import 'package:rogella_radio/utils/database_helper.dart';
import 'package:rogella_radio/utils/read_values.dart';

class SearchDetail extends StatefulWidget {
  String _searchText;

  SearchDetail(this._searchText);

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  DatabaseHelper dbHelper = new DatabaseHelper();
  bool _loadingCountry = false, _loadingRadios = false;
  List<Widget> _countryList;
  List<MyRadio> _radioList;
  String _selectedCountry = "All Countries";

  @override
  void initState() {
    super.initState();
    _countryList = new List<Widget>();
    _radioList = new List<MyRadio>();
    getCountries();
    getRadios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              height: 160,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 30),
              color: Color(ReadValues.getColor("dark_color")),
              child: Column(
                children: [
                  CategoryTopHeader(widget._searchText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FlatButton.icon(
                          color: Color(
                            ReadValues.getColor("filter_button"),
                          ),
                          onPressed: () => showCountries(),
                          label: Text(
                            _selectedCountry,
                            style: TextStyle(
                                color: Color(
                              ReadValues.getColor("filter_button_text"),
                            )),
                          ),
                          icon: Icon(
                            Icons.flag,
                            color: Color(
                              ReadValues.getColor("filter_button_text"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 130),
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
                : _radioList.length == 0
                    ? Align(
                        alignment: Alignment.center, child: Text("No result"))
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

  void filterRadiosCountry(String country_code) {
    setState(() {
      if (country_code == "")
        getRadios();
      else
        _radioList =
            _radioList.where((x) => x.countrycode == country_code).toList();
    });
  }

  void getCountries() async {
    setState(() {
      _loadingCountry = true;
    });
    _countryList = (await dbHelper.allCountry("country_name"))
        .map((country) => ListTile(
              title: Text(Country.fromMap(country).country_name),
              onTap: () {
                setState(() {
                  _selectedCountry =
                      Country.fromMap(country).country_name.length > 15
                          ? Country.fromMap(country)
                                  .country_name
                                  .substring(0, 12) +
                              "..."
                          : Country.fromMap(country).country_name;
                  filterRadiosCountry(Country.fromMap(country).country_code);
                  Navigator.pop(context);
                });
              },
            ))
        .toList();
    _countryList.insert(
        0,
        ListTile(
          title: Text(
            "All Countries",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            setState(() {
              _selectedCountry = "All Countries";
              filterRadiosCountry("");
              Navigator.pop(context);
            });
          },
        ));
    setState(() {
      _loadingCountry = false;
    });
  }

  void getRadios() async {
    setState(() {
      _loadingRadios = true;
    });
    _radioList = (await dbHelper.getSearchRadios(widget._searchText))
        .map((mradio) => MyRadio.fromMap(mradio))
        .toList();
    setState(() {
      _loadingRadios = false;
    });
  }

  void showCountries() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: _loadingCountry
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: new Wrap(children: _countryList),
                  ),
          );
        });
  }
}
