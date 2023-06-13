import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rti/src/dao/employee.dart';
import 'package:rti/src/utils/routes.dart';
import 'package:rti/src/utils/storage/storage_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  Get.lazyPut(() => EmployeeStorageService());
 // Get.lazyPut(() => FormerEmployeeStorageService());
 await Get.find<EmployeeStorageService>().init();
// await Get.find<FormerEmployeeStorageService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      getPages: AppPages.appPages,
      initialRoute: AppRoutes.employeeList,
    );
  }
}
