class ClientNames{
  int cNId;
  String cNName;

  ClientNames.withId({this.cNId, this.cNName});

  ClientNames({this.cNName});

  Map<String,dynamic> toMap(){
    var map = <String , dynamic>{};

    // TODO : map database column names from field names
    if (cNId != null)
    {
      map['c_n_id'] = cNId;
    }
    map['c_n_name'] = cNName;

    return map;
  }

  ClientNames.fromMapObject(Map<String, dynamic> map){
    //TODO : Map fields from data base column name
    this.cNId = map['c_n_id'];
    this.cNName = map['c_n_name'];
  }

}