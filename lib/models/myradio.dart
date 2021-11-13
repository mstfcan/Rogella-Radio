class MyRadio {
  int _id;
  String _stationuuid;
  String _name;
  String _url;
  String _url_resolved;
  String _homepage;
  String _favicon;
  String _tags;
  String _country;
  String _countrycode;
  String _state;
  String _language;
  String _votes;
  String _codec;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  MyRadio(
      this._stationuuid,
      this._name,
      this._url,
      this._url_resolved,
      this._homepage,
      this._favicon,
      this._tags,
      this._country,
      this._countrycode,
      this._state,
      this._language,
      this._votes,
      this._codec);

  MyRadio.withID(
      this._id,
      this._stationuuid,
      this._name,
      this._url,
      this._url_resolved,
      this._homepage,
      this._favicon,
      this._tags,
      this._country,
      this._countrycode,
      this._state,
      this._language,
      this._votes,
      this._codec);



  Map<String, dynamic> toMap() {
    var temp = new Map<String, dynamic>();
    temp["id"]=_id;
    temp["stationuuid"] = _stationuuid;
    temp["name"] = _name;
    temp["url"] = _url;
    temp["url_resolved"] = _url_resolved;
    temp["homepage"] = _homepage;
    temp["favicon"] = _favicon;
    temp["tags"] = _tags;
    temp["country"] = _country;
    temp["countrycode"] = _countrycode;
    temp["state"] = _state;
    temp["language"] = _language;
    temp["votes"] = _votes;
    temp["codec"] = _codec;
    return temp;
  }

  MyRadio.fromMap(Map<String, dynamic> temp) {
    this._id=temp["id"];
    this._stationuuid = temp["stationuuid"];
    this._name = temp["name"];
    this._url = temp["url"];
    this._url_resolved = temp["url_resolved"];
    this._homepage = temp["homepage"];
    this._favicon = temp["favicon"];
    this._tags = temp["tags"];
    this._country = temp["country"];
    this._countrycode = temp["countrycode"];
    this._state = temp["state"];
    this._language = temp["language"];
    this._votes = temp["votes"];
    this._codec = temp["codec"];
  }

  String get stationuuid => _stationuuid;

  String get codec => _codec;

  set codec(String value) {
    _codec = value;
  }

  String get language => _language;

  set language(String value) {
    _language = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get countrycode => _countrycode;

  set countrycode(String value) {
    _countrycode = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get tags => _tags;

  set tags(String value) {
    _tags = value;
  }

  String get favicon => _favicon;

  set favicon(String value) {
    _favicon = value;
  }

  String get homepage => _homepage;

  set homepage(String value) {
    _homepage = value;
  }

  String get url_resolved => _url_resolved;

  set url_resolved(String value) {
    _url_resolved = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set stationuuid(String value) {
    _stationuuid = value;
  }

  String get votes => _votes;

  set votes(String value) {
    _votes = value;
  }

}
