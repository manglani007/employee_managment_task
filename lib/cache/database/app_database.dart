import 'dart:math';

import 'package:employee_managment_task/cache/database/entity/employee.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/datasource/crud_datasource.dart';
import '../../data/entity/employee_data.dart';

const String _employeeBoxName = 'EmployeeBox';
const String _latestIdBoxName = "latestIdBox";
const String _latestIdName = "_latestId";

class AppDatabase extends CRUDDataSource {
  AppDatabase._constructor();

  static final AppDatabase _instance = AppDatabase._constructor();

  factory AppDatabase() => _instance;

  late Box _employeeBox;
  late Box _lastIdBox;

  Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(EmployeeEntityAdapter());
    _employeeBox = await Hive.openBox(_employeeBoxName);
    _lastIdBox = await Hive.openBox(_latestIdBoxName);
  }

  void close() {
    // Closes all Hive boxes
    Hive.close();
  }

  @override
  void saveEmployee(EmployeeData employee) async {
    try {
      print(Hive.isAdapterRegistered(200));
      int latestId = _lastIdBox.get(_latestIdName, defaultValue: 0);
      int newLatestId = latestId + 1;
      var employeeEntity = EmployeeEntity(
        id: newLatestId,
        name: employee.name,
        role: employee.role,
        joinDate: employee.joinDate.millisecondsSinceEpoch,
        leaveDate: employee.leaveDate == null
            ? 0
            : employee.leaveDate!.millisecondsSinceEpoch,
      );
      await _employeeBox.put(employeeEntity.id, employeeEntity);
      await _lastIdBox.put(_latestIdName, newLatestId);
    } catch (error) {
      print(error);
    }
  }

  @override
  void updateEmployee(int id, EmployeeData employee) async {
    try {
      print(employee.leaveDate);
      await _employeeBox.put(
          employee.id,
          EmployeeEntity(
              id: employee.id,
              name: employee.name,
              role: employee.role,
              joinDate: employee.joinDate.millisecondsSinceEpoch,
              leaveDate: employee.leaveDate == null
                  ? 0
                  : employee.leaveDate!.millisecondsSinceEpoch));
    } catch (error) {
      print(error);
    }
  }

  @override
  void deleteEmployee(int id) async {
    try {
      await _employeeBox.delete(id);
    } catch (error) {
      print(error);
    }
  }

  @override
  void deleteAllEmployeeList() async {
    try {
      await _employeeBox.clear();
    } catch (error) {
      print(error);
    }
  }

  @override
  List<EmployeeData> getAllEmployeeList() {
    return _employeeBox.values
        .map((e) => EmployeeData(
            e.id,
            e.name,
            e.role,
            DateTime.fromMillisecondsSinceEpoch(e.joinDate),
            e.leaveDate == 0
                ? null
                : DateTime.fromMillisecondsSinceEpoch(e.leaveDate)))
        .toList();
  }
}
