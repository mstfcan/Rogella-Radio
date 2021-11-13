class Category {
  String _cat_name;
  int _id;

  Category(this._cat_name);
  Category.withID(this._cat_name,this._id);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get cat_name=>_cat_name;
  set cat_name(String value){
    _cat_name=cat_name;
  }

  Map<String, dynamic> toMap() {
    var temp = new Map<String, dynamic>();
    temp["id"]=_id;
    temp["cat_name"] = _cat_name;
    return temp;
  }

  Category.fromMap(Map<String, dynamic> temp) {
    this._id=temp["id"];
    this._cat_name = temp["cat_name"];
  }

}
