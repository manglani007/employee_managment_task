import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../vo/employee_vo.dart';

class EmployeeListItem extends StatelessWidget {
  final EmployeeVO employeeVO;
  final Function onClickItem;
  final Function onClickDelete;

  const EmployeeListItem(
      {required this.employeeVO,
      required this.onClickItem,
      required this.onClickDelete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("deleted_employee_${employeeVO.id}"),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onClickDelete();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        onTap: () => onClickItem(),
        title: Text(
          employeeVO.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employeeVO.role,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (employeeVO.leaveDate == null)
              Text(
                "From ${DateFormat("dd,MMM yyyy").format(employeeVO.joinDate)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (employeeVO.leaveDate != null)
              Text(
                "${DateFormat("dd,MMM yyyy").format(employeeVO.joinDate)} - ${DateFormat("dd,MMM yyyy").format(employeeVO.leaveDate!)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}
