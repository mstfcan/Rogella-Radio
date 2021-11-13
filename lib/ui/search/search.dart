import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:rogella_radio/ui/animations/page_anitmations.dart';
import 'package:rogella_radio/ui/categories/category_detail_item.dart';
import 'package:rogella_radio/ui/listen/listen_radio.dart';
import 'package:rogella_radio/ui/search/search_detail.dart';
import 'package:rogella_radio/utils/database_helper.dart';
import 'package:rogella_radio/utils/read_values.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final _textController = new TextEditingController();
  String _search = "";
  String _errorText = "";
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
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Color(ReadValues.getColor("search_input_bg")),
                  child: TextFormField(
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),
              Card(
                color: Color(ReadValues.getColor("dark_color")),
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: goSearch),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              _errorText,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.red),
            ),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }

  void goSearch() {
    setState(() {
      _search = _textController.text.trim();
    });
    if (_search.isEmpty) {
      setState(() {
        _errorText = "Please enter some text";
      });
    } else if (_search.length < 3) {
      setState(() {
        _errorText = "Minimum 3 characters";
      });
    } else {
      setState(() {
        _errorText = "";
        _search = _search.length > 30 ? _search.substring(0, 30) : _search;
        FocusScope.of(context).unfocus();
        Navigator.push(context, SlideRightRoute(page: SearchDetail(_search)));
      });
    }
  }

  void getRadios() async {
    setState(() {
      _loadingRadios = true;
    });
    debugPrint((await dbHelper.getRandomRadios()).toString());
    _radioList = (await dbHelper.getRandomRadios())
        .map((mradio) => MyRadio.fromMap(mradio))
        .toList();
    setState(() {
      _loadingRadios = false;
    });
  }
}
