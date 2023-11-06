import 'package:employee_managment_task/app/bloc/employee_bloc.dart';
import 'package:employee_managment_task/app/bloc/employee_event.dart';
import 'package:employee_managment_task/app/helper/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'component/update_employee_form.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final EmployeeVO employee;

  const UpdateEmployeeScreen({
    super.key,
    required this.employee,
  });

  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Employee'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<EmployeeBloc>().add(EmployeeItemDeletedEvent(
                    widget.employee.id, widget.employee));
                context.pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateEmployeeForm(
          employee: widget.employee,
        ),
      ),
    );
  }

  _undoDelete(EmployeeVO employeeVO) {
    context.read<EmployeeBloc>().add(EmployeeItemUndoDeletedEvent(employeeVO));
  }
}
