import 'dart:io';
import 'package:employee_managment_task/app/page/add/component/calender_date_picker.dart';
import 'package:employee_managment_task/app/page/add/component/custom_date_picker.dart';
import 'package:employee_managment_task/app/page/common_widgets/dialogs.dart';
import 'package:employee_managment_task/app/theme/app_color.dart';
import 'package:flutter/material.dart' hide DatePickerMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';
import 'package:go_router/go_router.dart';
import '../../../bloc/employee_bloc.dart';
import '../../../bloc/employee_event.dart';
import '../../../bloc/employee_state.dart';
import '../../../helper/title_field_validator.dart';

class UpdateEmployeeForm extends StatefulWidget {
  final EmployeeVO employee;

  const UpdateEmployeeForm({
    required this.employee,
  });

  @override
  _UpdateEmployeeFormState createState() => _UpdateEmployeeFormState();
}

class _UpdateEmployeeFormState extends State<UpdateEmployeeForm> {
  final _employeeFormKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _role;
  late DateTime _joiningDate;
  late DateTime? _leavingDate;

  @override
  void initState() {
    super.initState();
    print(widget.employee.leaveDate);
    _nameController = TextEditingController(text: widget.employee.name);
    _role = TextEditingController(text: widget.employee.role);
    _joiningDate = widget.employee.joinDate;
    _leavingDate = widget.employee.leaveDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
      return Form(
        key: _employeeFormKey,
        child: ListView(
          children: [
            const SizedBox(height: 24.0),
            TextFormField(
              key: const Key('addEmployee_title_textFormField'),
              controller: _nameController,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: "Employee name",
                prefixIcon: Icon(Icons.person_2_outlined),
              ),
              validator: nameFieldValidator,
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              onTap: () {
                CustomDialogs.showRoleDialog(context).then((value) {
                  if (value != null) {
                    _role.text = value;
                  }
                });
              },
              key: const Key('addEmployee_description_textFormField'),
              decoration: const InputDecoration(
                  hintText: "Select role",
                  prefixIcon: Icon(Icons.person_2_outlined),
                  suffixIcon: Icon(Icons.arrow_drop_down)),
              controller: _role,
              readOnly: true,
              validator: roleFieldValidator,
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Flexible(
                    flex: 1,
                    child: FormFieldA(
                      mode: DatePickerMode.withDate,
                      initialValue: _joiningDate,
                      validator: (value) => value == null ? "Error" : null,
                      onSaved: (a) {
                        _joiningDate = a!;
                        print(_joiningDate);
                      },
                    )),
                const Icon(
                  Icons.arrow_forward_sharp,
                  color: primaryColor,
                ),
                Flexible(
                    flex: 1,
                    child: FormFieldA(
                      mode: DatePickerMode.noDate,
                      initialValue: _leavingDate,
                      onSaved: (a) {
                        _leavingDate = a;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_employeeFormKey.currentState!.validate()) {
                      _employeeFormKey.currentState!.save();
                      _updateInfo();
                      context.pop();
                    }
                  },
                  child: const Text('Update'),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _updateInfo() {
    EmployeeVO employeeVO = EmployeeVO(
        id: widget.employee.id,
        name: _nameController.text,
        role: _role.text,
        joinDate: _joiningDate,
        leaveDate: _leavingDate);
    context.read<EmployeeBloc>().add(EmployeeItemUpdatedEvent(employeeVO));
  }
}
