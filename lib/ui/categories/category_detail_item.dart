import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:rogella_radio/utils/read_values.dart';

class CategoryDetailItem extends StatelessWidget {
  MyRadio _radio;

  CategoryDetailItem(this._radio);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              alignment: Alignment.centerLeft,
              imageUrl: _radio.favicon,
              height: 60,
              fit: BoxFit.contain,
              placeholder: (context, url) => Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black54),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/no_logo_radio.png", fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              _radio.name.length >= 30
                  ? _radio.name.substring(0, 30) + "..."
                  : _radio.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
              flex: 2,
              child: Icon(
                Icons.play_circle_fill,
                color: Color(ReadValues.getColor("dark_color")),
              ))
        ],
      ),
    );
  }
}
