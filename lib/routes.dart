import 'package:routefly/routefly.dart';

import 'app/app_page.dart' as a0;
import 'app/checkers/pages/checkers_page.dart' as a1;
import 'app/chess/chess_page.dart' as a2;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/',
    uri: Uri.parse('/'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.AppPage(),
    ),
  ),
  RouteEntity(
    key: '/checkers/pages/checkers',
    uri: Uri.parse('/checkers/pages/checkers'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.CheckersPage(),
    ),
  ),
  RouteEntity(
    key: '/chess',
    uri: Uri.parse('/chess'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.ChessPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  checkers: (
    path: '/checkers',
    pages: (
      path: '/checkers/pages',
      checkers: '/checkers/pages/checkers',
    ),
  ),
  chess: '/chess',
);
