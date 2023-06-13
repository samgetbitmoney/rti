import 'package:get/get.dart';
import 'package:rti/src/screens/add_employee_details/views/add_employee_details.dart';
import 'package:rti/src/screens/add_employee_details/views/add_employee_details_bindings.dart';
import 'package:rti/src/screens/employee_list/employee_list.dart';

abstract class AppRoutes{
  static const String addEmployee="/add-employee";
  static const String employeeList='/employee-list';
}
abstract class AppPages{
static  List<GetPage> appPages=[
    GetPage(name: AppRoutes.employeeList, page: () =>  const EmployeeListPage()),
    GetPage(name: AppRoutes.addEmployee, page: () =>  const AddEmployeeDetails(),binding: EmployeeDetailsBindings())
  ];
}