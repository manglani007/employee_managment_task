import 'package:employee_managment_task/app/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool highlighted;

  const CustomButton(
      {super.key, this.onTap, required this.title, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: highlighted ? primaryColor : primaryLight,
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          height: 40,
          child: Text(
            title,
            style: TextStyle(
                color: highlighted ? Colors.white : primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
      ),
    );
  }
}
