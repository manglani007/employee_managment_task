import 'package:employee_managment_task/data/entity/employee_data.dart';

import '../../domain/model/employee_domain.dart';
import '../../domain/repository/employee_repository.dart';
import '../datasource/crud_datasource.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final CRUDDataSource dataSource;
  EmployeeRepositoryImpl(this.dataSource);

  @override
  void addEmployee(EmployeeDomain employeeDomain) {
    return dataSource.saveEmployee(EmployeeData(
        employeeDomain.id,
        employeeDomain.name,
        employeeDomain.role,
        employeeDomain.joinDate,
        employeeDomain.leaveDate));
  }

  @override
  void deleteEmployee(int id) {
    return dataSource.deleteEmployee(id);
  }

  @override
  List<EmployeeDomain> getEmployeeList() {
    return dataSource
        .getAllEmployeeList()
        .map((e) =>
            EmployeeDomain(e.id, e.name, e.role, e.joinDate, e.leaveDate))
        .toList();
  }

  @override
  void updateEmployee(EmployeeDomain employeeDomain) async {
    return dataSource.updateEmployee(
        employeeDomain.id,
        EmployeeData(
            employeeDomain.id,
            employeeDomain.name,
            employeeDomain.role,
            employeeDomain.joinDate,
            employeeDomain.leaveDate));
  }
}
