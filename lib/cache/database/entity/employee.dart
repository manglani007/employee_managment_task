import 'package:hive_flutter/hive_flutter.dart';

part 'employee.g.dart';

@HiveType(typeId: 201)
class EmployeeEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final int joinDate;

  @HiveField(4)
  final int leaveDate;

  EmployeeEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.joinDate,
    required this.leaveDate,
  });
}
