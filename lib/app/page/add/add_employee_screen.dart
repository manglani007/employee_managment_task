import 'package:flutter/material.dart';
import 'component/add_employee_form.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AddEmployeeForm(),
      ),
    );
  }
}
