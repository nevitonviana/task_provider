import '../../core/database/sqlite_connection_factory.dart';
import '../../models/task_model.dart';
import 'tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'todo',
      {
        'id': null,
        "descricao": description,
        "data_hora": date.toIso8601String(),
        "finalizado": 0,
      },
    );
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final starFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(start.year, start.month, start.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
select * form todo where data_hora between ? and ?
order by data_hora
''', [starFilter.toIso8601String(), endFilter.toIso8601String()]);
    return result.map((e) => TaskModel.loadFormBD(e)).toList();
  }
}
