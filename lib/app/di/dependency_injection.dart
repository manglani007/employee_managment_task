import 'package:employee_managment_task/app/bloc/employee_bloc.dart';
import 'package:employee_managment_task/data/repository_impl/employee_repository_impl.dart';
import 'package:employee_managment_task/domain/repository/employee_repository.dart';
import 'package:employee_managment_task/domain/usecase/undo_deleted_employee_usecase.dart';
import 'package:get_it/get_it.dart';
import '../../cache/database/app_database.dart';
import '../../data/datasource/crud_datasource.dart';
import '../../domain/usecase/add_employee_usecase.dart';
import '../../domain/usecase/delete_employee_usecase.dart';
import '../../domain/usecase/get_all_employee_usecase.dart';
import '../../domain/usecase/update_employee_usecase.dart';

GetIt getIt = GetIt.instance;

Future configureDependencies(CRUDDataSource database) async {
  //datasource
  getIt.registerLazySingleton<CRUDDataSource>(() => database);

  //repository
  getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(getIt()));

  //use case
  getIt.registerLazySingleton<GetAllEmployeeUseCase>(
      () => GetAllEmployeeUseCase(getIt()));
  getIt.registerLazySingleton<AddEmployeeUseCase>(
      () => AddEmployeeUseCase(getIt()));
  getIt.registerLazySingleton<UpdateEmployeeUseCase>(
      () => UpdateEmployeeUseCase(getIt()));

  getIt.registerLazySingleton<DeleteEmployeeUseCase>(
      () => DeleteEmployeeUseCase(getIt()));
  getIt.registerLazySingleton<UndoDeletedEmployeeUseCase>(
      () => UndoDeletedEmployeeUseCase(getIt()));

  //bloc
  getIt.registerFactory<EmployeeBloc>(() => EmployeeBloc(
      getAllEmployeeUseCase: getIt(),
      addEmployeeUseCase: getIt(),
      updateEmployeeUseCase: getIt(),
      deleteEmployeeUseCase: getIt(),
      undoDeletedEmployeeUseCase: getIt()));
}
