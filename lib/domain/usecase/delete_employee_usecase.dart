import 'package:employee_managment_task/domain/model/employee_domain.dart';
import 'package:employee_managment_task/domain/repository/employee_repository.dart';

class DeleteEmployeeUseCase {
  final EmployeeRepository repository;
  DeleteEmployeeUseCase(this.repository);

  void execute(int id) {
    return repository.deleteEmployee(id);
  }
}
