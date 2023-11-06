import 'package:employee_managment_task/domain/model/employee_domain.dart';
import 'package:employee_managment_task/domain/repository/employee_repository.dart';

class GetAllEmployeeUseCase {
  final EmployeeRepository repository;
  GetAllEmployeeUseCase(this.repository);

  List<EmployeeDomain> execute() {
    return repository.getEmployeeList();
  }
}
