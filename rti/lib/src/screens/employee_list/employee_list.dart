import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rti/src/dao/employee.dart';
import 'package:rti/src/screens/add_employee_details/data/employee_details_repo_impl.dart';
import 'package:rti/src/utils/app_colors.dart';
import 'package:rti/src/utils/routes.dart';
import 'package:rti/src/utils/storage/storage_service.dart';
import 'package:rti/src/widgets/svg_image.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EmployeeDetailsRepoImpl(Get.find()));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable:
                Get.find<EmployeeStorageService>().employeeBox.listenable(),
            builder: (context, Box<Employee> box, _) {
              if (box.isEmpty) {
                return Center(child: Image.asset("assets/zero_records.png"))
                    .marginOnly(top: 100);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeadingText("Current employees"),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: box.values.length,
                        itemBuilder: (_, index) {
                          Employee e = box.getAt(index)!;
                          if (e.endDate != null) {
                            return Container();
                          }
                          return EmployeeItemWidget(
                            e,
                          );
                        }),
                  ),
                  const HeadingText("Previous employees"),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: box.values.length,
                        itemBuilder: (_, index) {
                          Employee e = box.getAt(index)!;
                          if (e.endDate == null) {
                            return Container();
                          }
                          return EmployeeItemWidget(e);
                        }),
                  ),
                  const Text("Swipe left to delete",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.fontgrey))
                      .marginAll(16)
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addEmployee);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
            style: const TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold))
        .marginAll(16);
  }
}

class EmployeeItemWidget extends StatelessWidget {
  final Employee employee;
  const EmployeeItemWidget(
    this.employee, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(employee),
      onDismissed: (direction) {
        employee.delete();
        final snackBar = SnackBar(
          content: const Text('Employee data has been deleted'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              await Get.find<EmployeeDetailsRepoImpl>().saveDetails(employee);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [SvgImage("assets/delete.svg"), SizedBox(width: 21)],
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.addEmployee, arguments: employee);
        },
        child: Container(
          width: double.infinity,
          // height: 250,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
              ),
              const SizedBox(height: 16),
              Text(employee.role,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fontgrey)),
              const SizedBox(height: 16),
              Text(
                "From ${AppConstants.format1.format(employee.startDate)}${employee.endDate == null ? '' : ' - ${AppConstants.format1.format(employee.endDate!)}'}",
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.fontgrey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
