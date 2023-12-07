import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import 'routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Games',
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.chess,
      ),
    );
  }
}
