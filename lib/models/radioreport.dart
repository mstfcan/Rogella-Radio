class RadioReport{
  int _id;
  int _radio_id;
  String _stationuuid;

  int get radio_id => _radio_id;

  String get stationuuid => _stationuuid;

  set stationuuid(String value) {
    _stationuuid = value;
  }

  set radio_id(int value) {
    _radio_id = value;
  }

  RadioReport(this._radio_id, this._stationuuid);

  RadioReport.withID(this._id, this._radio_id, this._stationuuid);

  Map<String,dynamic> toMap(){
    var temp=new Map<String,dynamic>();
    temp["id"]=_id;
    temp["radio_id"]=_radio_id;
    temp["stationuuid"]=_stationuuid;
    return temp;
  }

  RadioReport.fromMap(Map<String,dynamic> temp){
    this._id=temp["id"];
    this._radio_id=temp["radio_id"];
    this._stationuuid=temp["stationuuid"];
  }
}

