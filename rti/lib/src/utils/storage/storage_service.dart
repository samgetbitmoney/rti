import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rti/src/dao/employee.dart';

class EmployeeStorageService extends GetxService {
 

  late Box<Employee> employeeBox;
  Future init() async {
    employeeBox = await Hive.openBox<Employee>('employeeListList');
  }

  Future<int?> saveEmployee(Employee value) async {
    try {
   int r=   await employeeBox.add(value);
return r;
    } catch (_) {
return null;
    }
  }

  Future updateEmployee(Employee value) async {
    try {
      await value.save();
    } catch (_) {}
  }

  Future deleteEmployee(Employee value) async {
    try {
      await value.delete();
    } catch (_) {}
  }
}
/* 
class FormerEmployeeStorageService extends GetxService {


  late Box<Employee> employeeBox;
  Future init() async {
    employeeBox = await Hive.openBox<Employee>('formerEmployeeList');
  }

  Future<int?> saveEmployee(Employee value) async {
    try {
   int r=   await employeeBox.add(value);
return r;
    } catch (_) {
return null;
    }
  }

  Future updateEmployee(Employee value) async {
    try {
      await value.save();
    } catch (_) {}
  }

  Future deleteEmployee(Employee value) async {
    try {
      await value.delete();
    } catch (_) {}
  }
}
 */