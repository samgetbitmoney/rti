import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rti/src/dao/employee.dart';
import 'package:rti/src/screens/add_employee_details/domain/employee_details_domain.dart';
import 'package:rti/src/utils/app_colors.dart';

class AddEmployeeDetailsController extends GetxController {
  final EmployeeDetailsRepo _detailsRepo;
  AddEmployeeDetailsController(this._detailsRepo);
  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  Employee? employee;
  getArguments() {
    employee = Get.arguments;
    if (employee == null) return;
    nameController.text = employee!.name;
    roleController.text = employee!.role;
    startDateController.text = AppConstants.format.format(employee!.startDate);
    if (employee!.endDate != null) {
      endDateController.text = AppConstants.format.format(employee!.endDate!);
      updateEndDate(employee!.endDate!);
    }
    updateStartDate(employee!.startDate);
    update();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  updateStartDate(DateTime val) {
    startDate = val;
  }

  updateEndDate(DateTime val) {
    endDate = val;
  }

  bool isLoading = false;
  bool isLoaded = false;
  bool isError = false;

  _changeStatus(bool loading, bool loaded, bool error) {
    isLoading = loading;
    isLoaded = loaded;
    isError = error;
    update();
  }

  void saveEmployee() async {
    if (isLoading) return;
    _changeStatus(true, false, false);
    int? result = await _detailsRepo.saveDetails(Employee(
        name: nameController.text,
        role: roleController.text,
        startDate: startDate!,
        endDate: endDate));
    _changeStatus(false, true, false);
    Get.back();
  }

  void updateEmployee() async {
    if (isLoading) return;
    _changeStatus(true, false, false);
    int? result = await _detailsRepo.deleteAndupdateDetails(employee!,endDate!);
    _changeStatus(false, true, false);
    Get.back();
  }
}
