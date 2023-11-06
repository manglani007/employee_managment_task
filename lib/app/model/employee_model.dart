import 'package:equatable/equatable.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';

class EmployeeModel extends Equatable {
  const EmployeeModel(
      {required this.currentEmployeeList, required this.pastEmployeeList});

  final List<EmployeeVO> currentEmployeeList;
  final List<EmployeeVO> pastEmployeeList;

  @override
  List<Object> get props => [currentEmployeeList, pastEmployeeList];
}
