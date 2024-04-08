import 'package:flutter/material.dart';

import 'modules/splash/spash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo List Provider ",
      home: SplashPage(),
    );
  }
}
