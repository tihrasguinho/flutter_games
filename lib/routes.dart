import 'package:routefly/routefly.dart';

import 'app/app_page.dart' as a0;
import 'app/features/checkers/pages/checkers_page.dart' as a1;
import 'app/features/domino/domino_page.dart' as a2;
import 'app/features/drag/drag_page.dart' as a3;
import 'app/features/tic_tac_toe/tic_tac_toe_page.dart' as a4;

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
    key: '/features/checkers/pages/checkers',
    uri: Uri.parse('/features/checkers/pages/checkers'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.CheckersPage(),
    ),
  ),
  RouteEntity(
    key: '/features/domino',
    uri: Uri.parse('/features/domino'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.DominoPage(),
    ),
  ),
  RouteEntity(
    key: '/features/drag',
    uri: Uri.parse('/features/drag'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a3.DragPage(),
    ),
  ),
  RouteEntity(
    key: '/features/tic_tac_toe',
    uri: Uri.parse('/features/tic_tac_toe'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a4.TicTacToePage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  features: (
    path: '/features',
    checkers: (
      path: '/features/checkers',
      pages: (
        path: '/features/checkers/pages',
        checkers: '/features/checkers/pages/checkers',
      ),
    ),
    domino: '/features/domino',
    drag: '/features/drag',
    ticTacToe: '/features/tic_tac_toe',
  ),
);
