import '../../models/task_model.dart';
import '../../models/week_task_model.dart';

abstract class TasksService {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getweek();
  Future<void> checkOrUncheckTask(TaskModel taskModel);
}
