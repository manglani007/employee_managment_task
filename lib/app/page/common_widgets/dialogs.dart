import 'package:employee_managment_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CustomDialogs {
  static Future<String?> showRoleDialog(BuildContext context) async {
    List<String> roleList = roleOptionsList;

    return await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        constraints: const BoxConstraints(maxHeight: 200),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.pop(roleList[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      roleList[index],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1,
                );
              },
              itemCount: roleList.length,
            ),
          );
        });
  }
}
