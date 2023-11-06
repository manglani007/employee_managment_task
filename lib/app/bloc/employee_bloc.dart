import 'package:bloc/bloc.dart';
import 'package:employee_managment_task/app/bloc/employee_event.dart';
import 'package:employee_managment_task/app/bloc/employee_state.dart';
import 'package:employee_managment_task/app/model/employee_model.dart';
import 'package:employee_managment_task/app/vo/employee_vo.dart';
import 'package:employee_managment_task/domain/model/employee_domain.dart';
import '../../domain/usecase/add_employee_usecase.dart';
import '../../domain/usecase/delete_employee_usecase.dart';
import '../../domain/usecase/get_all_employee_usecase.dart';

import '../../domain/usecase/undo_deleted_employee_usecase.dart';
import '../../domain/usecase/update_employee_usecase.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetAllEmployeeUseCase getAllEmployeeUseCase;
  final AddEmployeeUseCase addEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;

  final DeleteEmployeeUseCase deleteEmployeeUseCase;
  final UndoDeletedEmployeeUseCase undoDeletedEmployeeUseCase;
  EmployeeBloc(
      {required this.getAllEmployeeUseCase,
      required this.addEmployeeUseCase,
      required this.updateEmployeeUseCase,
      required this.deleteEmployeeUseCase,
      required this.undoDeletedEmployeeUseCase})
      : super(EmployeeLoadingState()) {
    on<EmployeeStartedEvent>(_onStarted);
    on<EmployeeItemAddedEvent>(_onItemAdded);
    on<EmployeeItemUpdatedEvent>(_onItemUpdated);
    on<EmployeeItemDeletedEvent>(_onItemDeleted);
    on<EmployeeItemUndoDeletedEvent>(_onItemUndoDeleted);
  }

  void _onStarted(
      EmployeeStartedEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    try {
      var dataList = getAllEmployeeUseCase.execute();
      List<EmployeeVO> cEmployeeVOList = [];
      List<EmployeeVO> prevEmployeeVOList = [];

      for (var emp in dataList) {
        var e = EmployeeVO(
            id: emp.id,
            name: emp.name,
            role: emp.role,
            joinDate: emp.joinDate,
            leaveDate: emp.leaveDate);
        if (emp.leaveDate == null) {
          cEmployeeVOList.add(e);
        } else {
          prevEmployeeVOList.add(e);
        }
      }

      emit(EmployeeLoadedState(EmployeeModel(
          currentEmployeeList: cEmployeeVOList,
          pastEmployeeList: prevEmployeeVOList)));
    } catch (e) {
      emit(const EmployeeErrorState());
    }
  }

  void _onItemAdded(
      EmployeeItemAddedEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    try {
      var employeeDomain = EmployeeDomain(
        event.employee.id,
        event.employee.name,
        event.employee.role,
        event.employee.joinDate,
        event.employee.leaveDate,
      );
      addEmployeeUseCase.execute(employeeDomain);

      add(EmployeeStartedEvent());
    } catch (_) {
      emit(const EmployeeErrorState());
    }
  }

  void _onItemUpdated(
      EmployeeItemUpdatedEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    try {
      var employeeDomain = EmployeeDomain(
        event.employee.id,
        event.employee.name,
        event.employee.role,
        event.employee.joinDate,
        event.employee.leaveDate,
      );
      updateEmployeeUseCase.execute(employeeDomain);
      add(EmployeeStartedEvent());
    } catch (_) {
      emit(const EmployeeErrorState());
    }
  }

  void _onItemDeleted(
      EmployeeItemDeletedEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    try {
      deleteEmployeeUseCase.execute(event.id);
      emit(EmployeeDeletedActionState(event.employee));

      add(EmployeeStartedEvent());
    } catch (_) {
      emit(const EmployeeErrorState());
    }
  }

  void _onItemUndoDeleted(
      EmployeeItemUndoDeletedEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    try {
      var employeeDomain = EmployeeDomain(
        event.employee.id,
        event.employee.name,
        event.employee.role,
        event.employee.joinDate,
        event.employee.leaveDate,
      );
      undoDeletedEmployeeUseCase.execute(employeeDomain);
      add(EmployeeStartedEvent());
    } catch (_) {
      emit(const EmployeeErrorState());
    }
  }
}
