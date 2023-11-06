import '../model/employee_domain.dart';

abstract class EmployeeRepository {
  List<EmployeeDomain> getEmployeeList();
  void addEmployee(EmployeeDomain employeeDomain);
  void updateEmployee(EmployeeDomain employeeDomain);
  void deleteEmployee(int id);
}
