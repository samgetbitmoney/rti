import 'package:get/get.dart';
import 'package:rti/src/screens/add_employee_details/data/employee_details_repo_impl.dart';
import 'package:rti/src/screens/add_employee_details/views/add_employee_details_controller.dart';

class EmployeeDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeDetailsRepoImpl(Get.find()));
    Get.lazyPut(() =>
        AddEmployeeDetailsController(Get.find<EmployeeDetailsRepoImpl>()));
  }
}
