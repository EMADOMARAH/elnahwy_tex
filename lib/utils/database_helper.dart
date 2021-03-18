import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/model/clientTypeModel.dart';
import 'package:elnahwy_tex/model/factoryClientModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:elnahwy_tex/model/factoryTypeModel.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;//Singleton DatabaseHelper
  static Database _database;

// Factory Types Table
  String factoryTypeTable = 'factoryType_table';
  String colFTId = 'f_t_id';
  String colFTName = 'f_t_name';
  String colFTSource = 'f_t_source';

  //Factory Clients Table
  String factoryClientTable = 'factoryClient_table';
  String colFCId = 'f_c_id';
  String colFCName= 'f_c_name';
  String colFCMeters = 'f_c_meters';
  String colFCTape = 'f_c_tape';
  String colFCNote = 'f_c_note';

  // Client Names Table
  String clientNamesTable = 'clientName_table';
  String colCNId = 'c_n_id';
  String colCNName = 'c_n_name';

  //Client Types Table
  String clientTypesTable = 'clientType_table';
  String colCTId = 'c_t_id';
  String colCTName= 'c_t_name';
  String colCTMeters = 'c_t_meters';
  String colCTTape = 'c_t_tape';
  String colCTNote = 'c_t_note';


  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //Enable ForeignKey
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database>initializeDatabase() async {
    // Get the Directory path for both android and ios to store data
    Directory directory= await getExternalStorageDirectory();
    String path = directory.path + 'nahwy.db';

    // Open/create the database at a given path
    var nahwyDatabase = await openDatabase(path,version: 2 ,onCreate: _createDb,onConfigure: _onConfigure);
    return nahwyDatabase;
  }

  void _createDb(Database db , int newVersion) async {
    //Factory Types Table Creation
    await db.execute(
        '''
        CREATE TABLE $factoryTypeTable
        ($colFTId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colFTSource TEXT,
        $colFTName TEXT
        )
        '''
    );
    await db.execute(
        '''
        CREATE TABLE $factoryClientTable
        ($colFCId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colFCName TEXT,
        $colFCMeters TEXT,
        $colFCTape TEXT,
        $colFCNote TEXT,
        $colFTId INTEGER,
        FOREIGN KEY ($colFTId) REFERENCES $factoryTypeTable ($colFTId) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
        '''
    );
    await db.execute(
        '''
        CREATE TABLE $clientNamesTable
        ($colCNId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colCNName TEXT
        )
        '''
    );
    await db.execute(
        '''
        CREATE TABLE $clientTypesTable
        ($colCTId INTEGER PRIMARY KEY AUTOINCREMENT,
         $colCTName TEXT,
        $colCTMeters TEXT,
        $colCTTape TEXT,
        $colCTNote TEXT,
        $colCNId INTEGER,
        FOREIGN KEY ($colCNId) REFERENCES $clientNamesTable ($colCNId) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
        '''
    );
  }

  //Fetch Operation : Get all nahwy objects from database
  //get all Factory Types Table depend on table name you give
  Future<List<Map<String,dynamic>>> getTableDataMapList(String tableName , String source) async{
    Database db = await this.database;
    var result = await db.query(
        tableName
        //,where: '$colFTSource = $source'
    );
    return result;
  }

  //Get Factory Clients table depend on foreign key
  Future<List<Map<String,dynamic>>> getSecondTableDataMapList(String tableName , String colName, int foreignKey) async{
    Database db = await this.database;
    var result = await db.query(
      tableName,
      columns: [colName],
      where: '$colName = $foreignKey'
    );
    return result;
  }


  //Insert Operation : Insert a nahwy object to Database
  Future<int> insertFactoryType(FactoryTypes types) async{
    Database db = await this.database;
    var result = await db.insert(factoryTypeTable, types.toMap());
    return result;
  }
  Future<int> insertFactoryClient(FactoryClients clients) async{
    Database db = await this.database;
    var result = await db.insert(factoryClientTable, clients.toMap());
    return result;
  }
  Future<int> insertClientName(ClientNames name) async{
    Database db = await this.database;
    var result = await db.insert(clientNamesTable, name.toMap());
    return result;
  }
  Future<int> insertClientType(ClientType type) async{
    Database db = await this.database;
    print (type.cTName);
    print (type.cTMeters);
    print (type.cTTape);
    print (type.cTNote);
    print (type.cTId);
    print (type.cNId);
    var result = await db.insert(clientTypesTable, type.toMap());
    return result;
  }
  //----------------------------------------------------------------------------

  //Update Operation : Update a nahwy object to Database
  Future<int> updateFactoryType(FactoryTypes type) async{
    Database db = await this.database;
    var result = await db.update(factoryTypeTable, type.toMap(),where: '$colFTId = ?', whereArgs: [type.fTId]);
    return result;
  }
  Future<int> updateFactoryClient(FactoryClients client) async{
    Database db = await this.database;
    var result = await db.update(factoryClientTable, client.toMap(),where: '$colFCId = ?', whereArgs: [client.fCId]);
    return result;
  }
  Future<int> updateClientName(ClientNames name) async{
    Database db = await this.database;
    var result = await db.update(clientNamesTable, name.toMap(),where: '$colCNId = ?', whereArgs: [name.cNId]);
    return result;
  }
  Future<int> updateClientType(ClientType type) async{
    Database db = await this.database;
    var result = await db.update(clientTypesTable, type.toMap(),where: '$colCTId = ?', whereArgs: [type.cTId]);
    return result;
  }
  //-------------------------------------------------------------------------------

  //Delete Operation : Delete any raw from any table in the fucking nahwy database
  Future<int> deleteRaw(String tableName,String idColumnName,int id) async{
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $tableName WHERE $idColumnName = $id');
    return result;
  }

  //Get Count Operation :  get Count of any table in the fucking database
  Future<int> getCountOfTable(String tableName) async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //GET CLIENT NAMES
  //get the 'Map List' [List<Map>] and convert it to 'ClientNames List' [List<ClientNames>]
  Future<List<ClientNames>> getClientNamesList() async {
    // get map List from DB
    var namesMapList = await getTableDataMapList(clientNamesTable,"");
    //count the number of map entries in DB table
    int count = namesMapList.length;

    List<ClientNames> namesList = List<ClientNames>();
    //for loop to create a 'ClientNames List' from Map List
    for (int i = 0; i < count; i++)
    {
      namesList.add(ClientNames.fromMapObject(namesMapList[i]));
    }

    return namesList;
  }

  //GET CLIENT Types
  //get the 'Map List' [List<Map>] and convert it to 'ClientTypes List' [List<ClientNames>]
  Future<List<ClientType>> getClientTypesList() async {
    // get map List from DB
    var typesMapList = await getTableDataMapList(clientTypesTable,"");
    //count the number of map entries in DB table
    int count = typesMapList.length;

    List<ClientType> typesList = List<ClientType>();
    //for loop to create a 'ClientTypes List' from Map List
    for (int i = 0; i < count; i++)
    {
      typesList.add(ClientType.fromMaoObject(typesMapList[i]));
    }

    return typesList;
  }

  //GET FACTORY Types
  //get the 'Map List' [List<Map>] and convert it to 'FactoryTypes List' [List<ClientNames>]
  Future<List<FactoryTypes>> getFactoryTypesList(String source) async {
    // get map List from DB
    var factoryTypesMapList = await getTableDataMapList(factoryTypeTable , source);
    //count the number of map entries in DB table
    int count = factoryTypesMapList.length;

    List<FactoryTypes> factoryTypesList = List<FactoryTypes>();
    //for loop to create a 'ClientTypes List' from Map List
    for (int i = 0; i < count; i++)
    {
      factoryTypesList.add(FactoryTypes.fromMapObject(factoryTypesMapList[i]));
    }

    return factoryTypesList;
  }

  //GET FACTORY CLIENTS
  //get the 'Map List' [List<Map>] and convert it to 'FactoryTypes List' [List<ClientNames>]
  Future<List<FactoryClients>> getFactoryClientsList() async {
    // get map List from DB
    var factoryClientsMapList = await getTableDataMapList(factoryClientTable,"");
    //count the number of map entries in DB table
    int count = factoryClientsMapList.length;

    List<FactoryClients> factoryClientsList = List<FactoryClients>();
    //for loop to create a 'ClientTypes List' from Map List
    for (int i = 0; i < count; i++)
    {
      factoryClientsList.add(FactoryClients.fromMaoObject(factoryClientsMapList[i]));
    }

    return factoryClientsList;
  }

}