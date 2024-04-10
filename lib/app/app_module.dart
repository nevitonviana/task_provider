import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Object(),
        )
      ],
      child: AppWidget(),
    );
  }
}
