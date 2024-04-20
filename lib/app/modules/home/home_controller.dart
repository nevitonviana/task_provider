import '../../core/notifier/default_change_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../../models/task_model.dart';
import '../../models/total_tasks_model.dart';
import '../../models/week_task_model.dart';
import '../../services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? todayTotaltasks;
  TotalTasksModel? tomorrowTotaltasks;
  TotalTasksModel? weekTotaltasks;

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getweek(),
    ]);

    final todoyTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotaltasks = TotalTasksModel(
        totalTasks: todoyTasks.length,
        totalTasksFinish: todoyTasks.where((task) => task.finished).length);
    weekTotaltasks = TotalTasksModel(
        totalTasks: todoyTasks.length,
        totalTasksFinish: tomorrowTasks.where((task) => task.finished).length);
    weekTotaltasks = TotalTasksModel(
        totalTasks: weekTasks.tasks.length,
        totalTasksFinish:
            weekTasks.tasks.where((task) => task.finished).length);
    notifyListeners();
  }
}
