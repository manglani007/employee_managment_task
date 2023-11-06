import 'package:equatable/equatable.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class EmployeeStartedEvent extends EmployeeEvent {
  @override
  List<Object?> get props => [];
}

class EmployeeItemAddedEvent extends EmployeeEvent {
  const EmployeeItemAddedEvent(this.employee);

  final EmployeeVO employee;

  @override
  List<Object?> get props => [employee];
}

class EmployeeItemUpdatedEvent extends EmployeeEvent {
  const EmployeeItemUpdatedEvent(this.employee);

  final EmployeeVO employee;

  @override
  List<Object?> get props => [employee];
}

class EmployeeItemDeletedEvent extends EmployeeEvent {
  final EmployeeVO employee;
  const EmployeeItemDeletedEvent(this.id, this.employee);

  final int id;

  @override
  List<Object?> get props => [id];
}

class EmployeeItemUndoDeletedEvent extends EmployeeEvent {
  const EmployeeItemUndoDeletedEvent(this.employee);

  final EmployeeVO employee;

  @override
  List<Object?> get props => [];
}
