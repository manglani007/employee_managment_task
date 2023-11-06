import 'package:employee_managment_task/app/helper/app_utils.dart';
import 'package:employee_managment_task/app/page/add/component/calender_date_picker.dart';
import 'package:employee_managment_task/app/page/add/component/custom_date_picker.dart';
import 'package:employee_managment_task/app/page/common_widgets/dialogs.dart';
import 'package:employee_managment_task/app/theme/app_color.dart';
import 'package:flutter/material.dart' hide CalendarDatePicker, DatePickerMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../bloc/employee_bloc.dart';
import '../../../bloc/employee_event.dart';
import '../../../bloc/employee_state.dart';

import '../../../helper/title_field_validator.dart';

class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({Key? key}) : super(key: key);

  @override
  _AddEmployeeFormState createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _name = TextEditingController();
  final _role = TextEditingController();
  final _employeeFormKey = GlobalKey<FormState>();
  DateTime? joiningDate = DateTime.now();
  DateTime? leavingDate;

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
              controller: _name,
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
                      initialValue: joiningDate,
                      validator: (value) => value == null ? "Error" : null,
                      onSaved: (a) {
                        joiningDate = a;
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
                      onSaved: (a) {
                        leavingDate = a;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _employeeFormKey.currentState!.save();
                    if (_employeeFormKey.currentState!.validate()) {
                      _employeeFormKey.currentState!.save();
                      if (leavingDate != null &&
                          joiningDate!.isAfter(leavingDate!)) {
                        AppUtils.showSnackBar(
                            context: context,
                            message:
                                "Leave date shuold be after than joining date",
                            label: "close",
                            onPress: () {});
                        return;
                      }
                      _addEmployee();
                      context.pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _addEmployee() async {
    EmployeeVO employeeVO = EmployeeVO(
      id: 0,
      name: _name.text,
      role: _role.text,
      joinDate: joiningDate!,
      leaveDate: leavingDate,
    );
    context.read<EmployeeBloc>().add(EmployeeItemAddedEvent(employeeVO));
  }
}
