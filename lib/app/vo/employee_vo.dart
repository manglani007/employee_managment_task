import 'package:equatable/equatable.dart';

class EmployeeVO extends Equatable {
  final int id;
  final String name;
  final String role;
  final DateTime joinDate;
  final DateTime? leaveDate;
  EmployeeVO({
    required this.id,
    required this.name,
    required this.role,
    required this.joinDate,
    this.leaveDate,
  });

  @override
  List<Object?> get props => [id, name, role, joinDate, leaveDate];
}
