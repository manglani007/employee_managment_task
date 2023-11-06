import 'package:employee_managment_task/domain/model/employee_domain.dart';
import 'package:employee_managment_task/domain/repository/employee_repository.dart';

class UndoDeletedEmployeeUseCase {
  final EmployeeRepository repository;
  UndoDeletedEmployeeUseCase(this.repository);

  void execute(EmployeeDomain employeeDomain) {
    return repository.addEmployee(employeeDomain);
  }
}
