import 'package:employee_managment_task/app/page/home/component/empty_list_placeholder.dart';
import 'package:employee_managment_task/app/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/employee_bloc.dart';
import '../../bloc/employee_event.dart';
import '../../bloc/employee_state.dart';
import '../../helper/app_utils.dart';
import '../../routing/app_route.dart';
import 'component/employee_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        actions: [
          IconButton(
              onPressed: () {
                AppUtils.showAboutDiilog(context: context);
              },
              icon: const Icon(Icons.info))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push("/${Routes.addScreen}"),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        buildWhen: (previous, current) {
          return current is! EmployeeDeletedActionState;
        },
        builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EmployeeLoadedState) {
            if (state.employeeModel.currentEmployeeList.isEmpty &&
                state.employeeModel.pastEmployeeList.isEmpty) {
              return const Center(
                child: EmptyListPlaceholder(),
              );
            } else {
              var textTheme = Theme.of(context).textTheme;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Current employees",
                      style: textTheme.headlineSmall!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  Expanded(
                    child: employeeListView(
                        state.employeeModel.currentEmployeeList),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Previous employees",
                      style: textTheme.headlineSmall!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  Expanded(
                    child:
                        employeeListView(state.employeeModel.pastEmployeeList),
                  ),
                ],
              );
            }
          }
          return const Text('Something went wrong!');
        },
        listener: (BuildContext context, EmployeeState state) {
          if (state is EmployeeDeletedActionState) {
            AppUtils.showSnackBar(
                context: context,
                message: '${state.employee.name} is deleted',
                label: 'Undo',
                onPress: () => {onClickUndo(state.employee)});
          }
        },
      ),
    );
  }

  Widget employeeListView(List<EmployeeVO> employees) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          var employeeVO = employees[index];
          return EmployeeListItem(
            employeeVO: employeeVO,
            onClickItem: () => {
              context.push("/${Routes.updateScreen}",
                  extra: {"employee": employeeVO})
            },
            onClickDelete: () => {
              context
                  .read<EmployeeBloc>()
                  .add(EmployeeItemDeletedEvent(employeeVO.id, employeeVO)),
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  void onClickUndo(EmployeeVO employeeVO) {
    context.read<EmployeeBloc>().add(EmployeeItemUndoDeletedEvent(employeeVO));
  }
}
