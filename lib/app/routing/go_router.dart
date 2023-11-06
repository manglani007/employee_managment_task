import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../page/add/add_employee_screen.dart';
import '../page/home/home_screen.dart';
import '../page/update/update_employee_screen.dart';
import 'app_route.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.addScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const AddEmployeeScreen();
          },
        ),
        GoRoute(
          path: Routes.updateScreen,
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return UpdateEmployeeScreen(
              employee: args['employee'],
            );
          },
        ),
      ],
    ),
  ],
);
