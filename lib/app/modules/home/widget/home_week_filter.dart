import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
          (controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "DIA DA SEMANA",
            style: context.titleStyle,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) => DatePicker(
                value,
                locale: 'pt_BR',
                height: 2,
                initialSelectedDate: value,
                selectionColor: context.primaryColor,
                selectedTextColor: Colors.white,
                daysCount: 7,
                monthTextStyle: const TextStyle(fontSize: 8),
                dayTextStyle: const TextStyle(fontSize: 13),
                dateTextStyle: const TextStyle(fontSize: 13),
                onDateChange: (selectedDate) =>
                    context.read<HomeController>().filterByDay(selectedDate),
              ),
            ),
          )
        ],
      ),
    );
  }
}
