import '../entity/employee_data.dart';

abstract class CRUDDataSource {
  List<EmployeeData> getAllEmployeeList();
  void saveEmployee(EmployeeData employee);
  void updateEmployee(int id, EmployeeData employee);
  void deleteEmployee(int id);
  void deleteAllEmployeeList();
}
