import 'package:remember_password/model/password_model.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

class DbManager {
//数据库版本名称
  static const _DB_NAME = 'my_db.db';

  static DbManager? _instance;
  late Database _database;
  DbManager._();

  static DbManager instance() {
    _instance ??= DbManager._();
    return _instance!;
  }

  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DB_NAME);

    _database = await openDatabase(path,
      version: 1, password: "password",
        onCreate: (Database db, int version) async {
          // 创建数据库时创建表
          await db.execute('CREATE TABLE ${PasswordModel.TABLE_NAME} (ID	INTEGER PRIMARY KEY AUTOINCREMENT , lable TEXT , account TEXT, password TEXT, createTime INTEGER)');
        }, );
  }

  Future<List<PasswordModel>> getPasswords() async {

    final list = await _database.transaction((txn) async => await txn.rawQuery('SELECT * FROM ${PasswordModel.TABLE_NAME} order by createTime desc '));

    List<PasswordModel> _list = [];

    list.forEach((element) {
      _list.add(PasswordModel.fromJson(element));
    });

    return _list;
  }

  Future<int> savePassword(PasswordModel model) async {

    int result;

    result = await _database.transaction((txn) async {
      return await txn.insert(PasswordModel.TABLE_NAME, model.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    });

    return result;
  }


  Future<int> deletePassword(PasswordModel model) async {

    int result;

    result = await _database.transaction((txn) async {
      return await txn.delete(PasswordModel.TABLE_NAME,where: 'ID = ?',whereArgs: [model.ID]);
    });

    return result;
  }


final _upgrades = {

};

// static DbUpgrade _sqlExecutor(List<String> sqls) {
//   return (db) => Future.forEach(sqls, (sql) => db.execute(sql));
// }
//
// _onUpgrade(Database db, int oldVersion, int newVersion) async {
//   debugPrint("_onUpgrade $oldVersion to $newVersion ");
//   final upgrades =
//       List<int>.generate(newVersion - oldVersion, (i) => oldVersion + i + 1)
//           .map((i) => _upgrades[i])
//           .where((i) => i != null)
//           .toList();
//   await Future.forEach(upgrades, (f) => f(db));
// }
}
