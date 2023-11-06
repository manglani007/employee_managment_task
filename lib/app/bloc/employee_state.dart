import 'package:employee_managment_task/app/vo/employee_vo.dart';
import 'package:equatable/equatable.dart';

import '../model/employee_model.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeLoadingState extends EmployeeState {}

class EmployeeLoadedState extends EmployeeState {
  const EmployeeLoadedState(this.employeeModel);

  final EmployeeModel employeeModel;

  @override
  List<Object> get props => [employeeModel];
}

class EmployeeErrorState extends EmployeeState {
  const EmployeeErrorState();
}

class EmployeeDeletedActionState extends EmployeeState {
  final EmployeeVO employee;
  const EmployeeDeletedActionState(this.employee);
}
