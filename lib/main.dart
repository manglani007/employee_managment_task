import 'package:employee_managment_task/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:employee_managment_task/app/bloc/employee_bloc.dart';
import 'package:employee_managment_task/app/routing/go_router.dart';
import 'package:hive/hive.dart';
import 'app/bloc/employee_event.dart';
import 'app/di/dependency_injection.dart';
import 'cache/database/app_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase database = AppDatabase();
  await database.initialize();
  configureDependencies(database);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final EmployeeBloc employeeBloc = getIt<EmployeeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => employeeBloc..add(EmployeeStartedEvent()),
          )
        ],
        child: MaterialApp.router(
          title: 'EMS - Rohit',
          theme: ApplicationTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        ));
  }
}
