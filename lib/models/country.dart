class Country {
  String _country_name;
  String _country_code;
  int _id;

  String get country_name => _country_name;

  set country_name(String value) {
    _country_name = value;
  }

  String get country_code => _country_code;

  set country_code(String value) {
    _country_code = value;
  }

  Country(this._country_name,this._country_code);
  Country.withID(this._country_name,this._country_code,this._id);


  Map<String, dynamic> toMap() {
    var temp = new Map<String, dynamic>();
    temp["id"]=_id;
    temp["country_name"] = _country_name;
    temp["country_code"] = _country_code;
    return temp;
  }

  Country.fromMap(Map<String, dynamic> temp) {
    this._id=temp["id"];
    this._country_name = temp["country_name"];
    this._country_code = temp["country_code"];
  }
}
