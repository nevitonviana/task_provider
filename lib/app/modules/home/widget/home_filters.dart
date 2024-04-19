import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';
import 'todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filtros",
          style: context.titleStyle,
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: "HOJE",
                taskFilterEnum: TaskFilterEnum.today,
                totalTasksModel: const TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: "AMANHÃ",
                taskFilterEnum: TaskFilterEnum.tomorrow,
                totalTasksModel: const TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: "SEMANA",
                taskFilterEnum: TaskFilterEnum.week,
                totalTasksModel: const TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
