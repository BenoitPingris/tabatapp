import 'package:sqflite/sqflite.dart';
import 'package:tabatapp/services/database.dart';
import 'package:tabatapp/utils/id.dart';

class Training {
  final String name;
  final int prepare;
  final int nbSeries;
  final int serieDuration;
  final int nbCycles;
  final int rest;
  String id;

  static final String _tableName = 'training';
  static final String _columnId = '_id';
  static final String _columnTitle = 'title';
  static final String _columnRest = 'rest';
  static final String _columnPrepare = 'prepare';
  static final String _columnNbSeries = 'nb_series';
  static final String _columnNbCycles = 'nb_cycles';
  static final String _columnSerieDuration = 'serie_duration';

  Training(
      {this.name,
      this.prepare,
      this.nbSeries,
      this.serieDuration,
      this.nbCycles,
      this.rest,
      this.id}) {
    if (id == null) {
      id = getRandomString(10);
    }
  }

  static Future<void> onCreate(Database db, int version) {
    return db.execute('''
    CREATE TABLE $_tableName (
      $_columnId TEXT NON NULL,
      $_columnTitle TEXT NON NULL,
      $_columnRest INTEGER NON NULL,
      $_columnPrepare INTEGER NON NULL,
      $_columnNbSeries INTEGER NON NULL,
      $_columnNbCycles INTEGER NON NULL,
      $_columnSerieDuration INTEGER NON NULL
    )''');
  }

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
        name: json[_columnTitle],
        prepare: json[_columnPrepare],
        rest: json[_columnRest],
        nbSeries: json[_columnNbSeries],
        nbCycles: json[_columnNbCycles],
        serieDuration: json[_columnSerieDuration],
        id: json[_columnId]);
  }

  static Future<List<Training>> fetch() async {
    var db = await DatabaseHelper.instance.database;
    var res = await db.query(_tableName);
    return res.map((i) => Training.fromJson(i)).toList();
  }

  Future create() async {
    var db = await DatabaseHelper.instance.database;
    return await db.insert(_tableName, toMap());
  }

  Future remove() async {
    var db = await DatabaseHelper.instance.database;
    return db.delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

  Map<String, dynamic> toMap() => ({
        _columnTitle: name,
        _columnPrepare: prepare,
        _columnNbSeries: nbSeries,
        _columnSerieDuration: serieDuration,
        _columnNbCycles: nbCycles,
        _columnRest: rest,
        _columnId: id,
      });

  String totalDuration() {
    final Duration duration = Duration(
        seconds: prepare +
            (nbSeries * serieDuration * nbCycles) +
            (rest * (nbSeries - 1) * nbCycles) +
            rest * 2 * (nbCycles - 1));
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
