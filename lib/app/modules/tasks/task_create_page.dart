import 'package:flutter/material.dart';

import 'task_create_controller.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreateController _controller;

  TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
