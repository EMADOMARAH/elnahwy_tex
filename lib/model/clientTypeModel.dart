class ClientType{
  int cTId;
  String cTName;
  String cTMeters ;
  String cTTape ;
  String cTNote ;

  ClientType.withId({this.cTId, this.cTName, this.cTMeters, this.cTTape, this.cTNote});

  ClientType({this.cTName, this.cTMeters, this.cTTape, this.cTNote});

  Map<String,dynamic> toMap(){
    var map = <String , dynamic>{};

    // TODO : map database column names from field names
    if (cTId != null)
    {
      map['c_t_id'] = cTId;
    }
    map['c_t_name'] = cTName;
    map['c_t_meters'] = cTMeters;
    map['c_t_tape'] = cTTape;
    map['c_t_note'] = cTNote;

    return map;
  }

  ClientType.fromMaoObject(Map<String, dynamic> map){
    //TODO : Map fields from data base column name
    this.cTId = map['c_t_id'];
    this.cTName = map['c_t_name'];
    this.cTMeters = map['c_t_meters'];
    this.cTTape = map['c_t_tape'];
    this.cTNote = map['c_t_note'];

  }



}