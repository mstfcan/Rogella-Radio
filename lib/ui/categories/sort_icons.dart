import 'package:flutter/material.dart';

class OneIcon extends StatelessWidget {
  Color _currentColor;
  double _height, _width;

  OneIcon(this._currentColor, this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
          color: _currentColor, borderRadius: BorderRadius.circular(2)),
    );
  }
}

class TwoIcon extends StatelessWidget {
  Color _currentColor;
  double _height, _width;

  TwoIcon(this._currentColor, this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 2),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: _currentColor, borderRadius: BorderRadius.circular(2)),
        ),
        Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: _currentColor, borderRadius: BorderRadius.circular(2)),
        ),
      ],
    );
  }
}

class ThreeIcon extends StatelessWidget {
  Color _currentColor;
  double _height, _width;

  ThreeIcon(this._currentColor, this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 2),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: _currentColor, borderRadius: BorderRadius.circular(2)),
        ),Container(
          margin: EdgeInsets.only(right: 2),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: _currentColor, borderRadius: BorderRadius.circular(2)),
        ),
        Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: _currentColor, borderRadius: BorderRadius.circular(2)),
        ),
      ],
    );
  }
}