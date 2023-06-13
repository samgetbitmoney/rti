import 'package:rti/src/dao/employee.dart';

abstract class EmployeeDetailsRepo{
  Future saveDetails(Employee value);
  Future deleteAndupdateDetails(Employee value,DateTime endDate);
}