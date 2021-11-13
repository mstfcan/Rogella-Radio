import 'package:flutter/material.dart';
import 'package:rogella_radio/models/category.dart';
import 'package:rogella_radio/ui/animations/page_anitmations.dart';
import 'package:rogella_radio/ui/categories/category_detail.dart';
import 'package:rogella_radio/utils/read_values.dart';

class CategoryItem extends StatelessWidget {
  Category _category;

  CategoryItem(this._category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, SlideRightRoute(page: CategoryDetail(_category))),
      child: SizedBox(
        height: 70,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 15),
          color: Color(ReadValues.getColor("dark_color")),
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _category.cat_name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset("assets/images/category_melody.png",
                    fit: BoxFit.contain,width: 60,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
