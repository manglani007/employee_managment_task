import 'package:employee_managment_task/app/page/add/component/calender_date_picker.dart';
import 'package:flutter/material.dart' hide DatePickerMode;
import 'package:intl/intl.dart';

class FormFieldA extends FormField<DateTime?> {
  FormFieldA(
      {super.key,
      FormFieldValidator<DateTime?>? validator,
      DateTime? initialValue,
      DateTime? startDate,
      FormFieldSetter<DateTime?>? onSaved,
      required DatePickerMode mode})
      : super(
            initialValue: initialValue,
            validator: validator,
            onSaved: onSaved,
            builder: (field) {
              return TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month)),
                readOnly: true,
                onTap: () async {
                  var a = await showDialog(
                      context: field.context,
                      builder: (a) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          insetPadding: EdgeInsets.zero,
                          contentPadding: const EdgeInsets.all(10),
                          content: SizedBox(
                            width: MediaQuery.of(field.context).size.width - 50,
                            //height: 500,
                            child: CustomCalendarDatePicker(
                              initialDate: field.value,
                              firstDate: startDate ?? DateTime(2010),
                              lastDate: DateTime(2050),
                              initialCalendarMode: mode,
                              onDateChanged: (DateTime? value) {},
                              onDateSubmitted: (DateTime? value) {
                                Navigator.pop(field.context, value);
                              },
                            ),
                          ),
                        );
                      });
                  field.didChange(a);
                },
                controller: TextEditingController(
                    text: field.value == null
                        ? "No Date"
                        : DateUtils.isSameDay(DateTime.now(), field.value!)
                            ? "Today"
                            : DateFormat("dd MMM yyyy").format(field.value!)),
              );
            });
}
