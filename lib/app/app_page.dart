import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_games/routes.dart';
import 'package:routefly/routefly.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() => Routefly.navigate(routePaths.features.checkers.pages.checkers));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
