import 'package:rti/src/dao/employee.dart';
import 'package:rti/src/utils/storage/storage_service.dart';

import '../domain/employee_details_domain.dart';

class EmployeeDetailsRepoImpl extends EmployeeDetailsRepo {
  final EmployeeStorageService _employeeStorageService;
  EmployeeDetailsRepoImpl(this._employeeStorageService,);
  @override
  Future<int?> saveDetails(Employee value) async {
      return  await _employeeStorageService.saveEmployee(value);

 
  }

  @override
  Future deleteAndupdateDetails(Employee value,DateTime endDate) async {
    value.endDate=endDate;
    await _employeeStorageService.updateEmployee(value);
  }
}
