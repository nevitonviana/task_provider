import 'package:flutter/material.dart';

import '../ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/logo.png"),
        Text(
          "Todo List",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
