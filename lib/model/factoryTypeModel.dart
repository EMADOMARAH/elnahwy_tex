class FactoryTypes{
  int fTId;
  String fTName;
  String fTSource;



  FactoryTypes({this.fTName, this.fTSource});
  FactoryTypes.withId({this.fTId, this.fTName, this.fTSource});



  Map<String,dynamic> toMap(){
    var map = <String , dynamic>{};

    // TODO : map database column names from field names
    if (fTId != null)
    {
      map['f_t_id'] = fTId;
    }
    map['f_t_name'] = fTName;
    map['f_t_source'] = fTSource;

    return map;
  }

  FactoryTypes.fromMapObject(Map<String, dynamic> map){
    //TODO : Map fields from data base column name
    this.fTId = map['f_t_id'];
    this.fTName = map['f_t_name'];
    this.fTSource = map['f_t_source'];
  }
  
}