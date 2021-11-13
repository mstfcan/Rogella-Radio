import 'package:flutter/material.dart';

class CategoryTopHeader extends StatelessWidget {

  String _cat_name;
  CategoryTopHeader(this._cat_name);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
              padding: EdgeInsets.only(left: 10),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context)),
        ),
        Expanded(
          flex: 11,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              _cat_name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
        ),
      ],
    );
  }
}
