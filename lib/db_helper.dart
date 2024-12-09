import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBHelper {
  static Database? _db;

  Future<Database> _getDatabase() async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE kullanicilar(id INTEGER PRIMARY KEY AUTOINCREMENT, ad TEXT, soyad TEXT, kullaniciAdi TEXT, parola TEXT, dogumTarihi TEXT, cinsiyet TEXT, hobiler TEXT)',
        );
      },
      version: 1,
    );
    return _db!;
  }

  Future<void> kullaniciEkle(Map<String, dynamic> kullanici) async {
    final db = await _getDatabase();
    await db.insert('kullanicilar', kullanici, conflictAlgorithm: ConflictAlgorithm.replace);

    // Kullanıcı bilgilerini SharedPreferences'e kaydet
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ad', kullanici['ad']);
    prefs.setString('soyad', kullanici['soyad']);
    prefs.setString('kullaniciAdi', kullanici['kullaniciAdi']);
    prefs.setString('dogumTarihi', kullanici['dogumTarihi']);
    prefs.setString('cinsiyet', kullanici['cinsiyet']);
    prefs.setString('hobiler', kullanici['hobiler']);
  }

  Future<List<Map<String, dynamic>>> tumKullanicilariGetir() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('kullanicilar');
    return maps;
  }
}
