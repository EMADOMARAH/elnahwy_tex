class FactoryClients{
  int fCId;
  String fCName;
  String fCMeters ;
  String fCTape ;
  String fCNote ;
  int fTId;

  FactoryClients({this.fCName, this.fCMeters, this.fCTape, this.fCNote,this.fTId});

  FactoryClients.withId({this.fCId, this.fCName, this.fCMeters, this.fCTape, this.fCNote,this.fTId});

  Map<String,dynamic> toMap(){
    var map = <String , dynamic>{};

    // TODO : map database column names from field names
    if (fCId != null)
    {
      map['f_c_id'] = fCId;
    }
    map['f_c_name'] = fCName;
    map['f_c_meters'] = fCMeters;
    map['f_c_tape'] = fCTape;
    map['f_c_note'] = fCNote;
    map['f_t_id'] = fTId;

    return map;
  }

  FactoryClients.fromMaoObject(Map<String, dynamic> map){
    //TODO : Map fields from data base column name
    this.fCId = map['f_c_id'];
    this.fCName = map['f_c_name'];
    this.fCMeters = map['f_c_meters'];
    this.fCTape = map['f_c_tape'];
    this.fCNote = map['f_c_note'];
    this.fTId = map['f_t_id'];

  }


}