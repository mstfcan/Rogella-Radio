import 'package:flutter/material.dart';
import 'package:rogella_radio/models/country.dart';
import 'package:rogella_radio/ui/animations/page_anitmations.dart';
import 'package:rogella_radio/ui/countries/country_detail.dart';
import 'package:rogella_radio/utils/database_helper.dart';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  List<Country> _countryList;
  bool _loading = false;
  DatabaseHelper dbHelper = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _countryList = new List<Country>();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: _countryList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    SlideRightRoute(
                        page: CountryDetail(_countryList[index].country_code,
                            _countryList[index].country_name))),
                child: Column(
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.asset(
                          "assets/flags/" +
                              _countryList[index].country_code.toLowerCase() +
                              ".png",
                          fit: BoxFit.cover,
                          height: 60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _countryList[index].country_name.length > 20
                            ? _countryList[index]
                                    .country_name
                                    .substring(0, 20) +
                                "..."
                            : _countryList[index].country_name,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            });
  }

  void getCountries() async {
    setState(() {
      _loading = true;
    });
    _countryList = (await dbHelper.allCountry("country_name"))
        .map((x) => Country.fromMap(x))
        .toList();
    setState(() {
      _loading = false;
    });
  }
}
