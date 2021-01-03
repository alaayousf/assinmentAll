import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'Task.dart';
class Dbhelper {

  //this is the privet named Constructor cannot inite opject out side this class
  Dbhelper._();
  static final Dbhelper dahelper = Dbhelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print('create f');
      return _database;
    } else {
      _database = await initDb();
      print('create T');
      return _database;
    }
  }

  String tabaleName = "Studant";
  static String idColumn = 'idColumn';
  static String taskName = 'taskName';
  static String taskState = 'taskState';


  initDb() async {

    var appDocDir = await getApplicationDocumentsDirectory();
    //String path1 = '${appDocDir.path}/Tasckdb.db';
    String path2 = join(appDocDir.path, 'Tasckadddb.db');
    // _database = await openDatabase(path2, version: 2,onOpen: (db){},);
    return await openDatabase(path2, version:1,onOpen: (db) {
      print("Print Open First time ");
      db.execute('''CREATE TABLE $tabaleName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $taskName TEXT, $taskState INTEGER)''');
    },
      //     onUpgrade: (db, oldevargen, newvargen) {
      //   print("Print upgradxddddddddddddddddddddddddddd");
      //   if (newvargen > oldevargen) {
      //     db.execute('DROP TABLE IF EXISTS $tabaleName');
      //     db.execute('''CREATE TABLE $tabaleName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $lastnameColumn TEXT, $magerColumn TEXT)''');
      //   }
      // }
    );

  }

  ceateTasckTapel() async {
    Database db = await database;
    await db.execute('''CREATE TABLE $tabaleName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $taskName TEXT, $taskState INTEGER)''');
  }



  insertNewRow(Task task) async{
    Database db = await database;
    var x= await db.insert(tabaleName, task.toMap());
    print('sssssssss ${x.toString()}');
  }

  delete(Task task) async{
    Database db = await database;
    var x= await db.delete(tabaleName, where: '$idColumn = ?', whereArgs: [task.idColumntask]);;
    print('sssssssss ${x.toString()}');
  }


  update(Task task) async{
    Database db = await database;
    var x= await db.update(tabaleName, task.toMap(),
        where: '$idColumn = ?', whereArgs: [task.idColumntask]);
    print('sssssssss ${x.toString()}');
  }


  Future<List<Task>> gretraveData() async{
    Database db = await database;
    List<Map<String,dynamic>> rowdata= await db.rawQuery('SELECT * FROM $tabaleName ');
    try{
      List<Task> list=rowdata.map((item) => Task.formJason(item)).toList();
      return list;
    }catch(e){
      print('$e');
    }
  }


  Future<List<Task>> getTasckUnCompleted() async{
    Database db = await database;
    List<Map<String,dynamic>> rowdata= await db.rawQuery('SELECT * FROM $tabaleName WHERE $taskState == 0');
    try{
      List<Task> list=rowdata.map((item) => Task.formJason(item)).toList();
      return list;
    }catch(e){
      print('$e');
    }
  }


  Future<List<Task>> getTasckCompleted() async{
    Database db = await database;
    List<Map<String,dynamic>> rowdata= await db.rawQuery('SELECT * FROM $tabaleName WHERE $taskState == 1');
    try{
      List<Task> list=rowdata.map((item) => Task.formJason(item)).toList();
      return list;
    }catch(e){
      print('$e');
    }
  }

}
