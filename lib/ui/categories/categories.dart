import 'package:flutter/material.dart';
import 'package:rogella_radio/models/category.dart';
import 'package:rogella_radio/ui/categories/category_item.dart';
import 'package:rogella_radio/utils/database_helper.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  DatabaseHelper dbHelper = new DatabaseHelper();
  bool _loading = false;
  List<Category> _category_list;

  @override
  void initState() {
    super.initState();
    _category_list=new List<Category>();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: _loading
          ? Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _category_list.length,
              itemBuilder: (context, index) {
                return CategoryItem(_category_list[index]);
              }),
    );
  }

  void getCategories() async{
    setState(() {
      _loading=true;
    });
    _category_list=(await dbHelper.allCategories()).map((item) => Category.fromMap(item)).toList();
    setState(() {
      _loading=false;
    });
  }

}
