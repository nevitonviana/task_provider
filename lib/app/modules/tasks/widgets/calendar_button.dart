import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 10 * 365));
        final DateTime? selectedDate = await showDatePicker(
            context: context, firstDate: DateTime(2000), lastDate: lastDate);
        // ignore: use_build_context_synchronously
        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today_rounded,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (BuildContext context, selectedDate, Widget? child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(
                      selectedDate,
                    ),
                    style: context.titleStyle,
                  );
                } else {
                  return Text(
                    "SELECIONE UMA DATA ",
                    style: context.titleStyle,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
