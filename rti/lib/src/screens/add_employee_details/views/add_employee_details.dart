import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rti/src/utils/app_colors.dart';
import 'package:rti/src/widgets/svg_image.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_employee_details_controller.dart';

class AddEmployeeDetails extends StatelessWidget {
  const AddEmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AddEmployeeDetailsController con = Get.find<AddEmployeeDetailsController>();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Employee Details"),
          automaticallyImplyLeading: false),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Form(
            key: con.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: GetBuilder<AddEmployeeDetailsController>(builder: (_) {
              return ListView(
                //  shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  DetailsWidget("Employee name", "person", con.nameController,
                      readOnly: _.employee != null),
                  const SizedBox(height: 23),
                  DetailsWidget(
                    "Select role",
                    "suitcase",
                    con.roleController,
                    suffixIcon: const Icon(Icons.arrow_drop_down,
                        size: 36, color: Colors.blue),
                    readOnly: true,
                    onTap: _.employee == null
                        ? () {
                            List<String> roles = [
                              "Product Designer",
                              "Flutter Developer",
                              "QA Tester",
                              "Product Owner"
                            ];
                            Get.bottomSheet(Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24),
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: roles.length,
                                itemBuilder: (context, index) {
                                  return RoleWidget(
                                    roles[index],
                                    () {
                                      con.roleController.text = roles[index];
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ));
                          }
                        : null,
                  ),
                  const SizedBox(height: 23),
                  Row(
                    children: [
                      Expanded(
                          child: DetailsWidget(
                        "",
                        "calender",
                        con.startDateController,
                        readOnly: true,
                        onTap: _.employee == null
                            ? () async {
                                DateTime? startDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000));
                                if (startDate != null) {
                                  con.startDateController.text =
                                      AppConstants.format.format(startDate);
                                  con.updateStartDate(startDate);
                                }
                              }
                            : null,
                      )),
                      const Icon(Icons.arrow_forward, color: Colors.blue)
                          .marginSymmetric(horizontal: 23),
                      Expanded(
                          child: DetailsWidget(
                        "",
                        "calender",
                        readOnly: true,
                        con.endDateController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return null;
                          }
                          if (con.startDate != null &&
                              con.endDate!.isBefore(con.startDate!)) {
                            return "Please enter a valid date";
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? endDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000));
                          if (endDate != null) {
                            con.endDateController.text =
                                AppConstants.format.format(endDate);
                            con.updateEndDate(endDate);
                          }
                        },
                      )),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
     
        const Divider(height: 10, thickness: 2, color: AppColors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue, // Background color
                  foregroundColor: Colors.blue, // Text Color (Foreground color)
                ),
                child: const Text("Cancel")),
            const SizedBox(width: 16),
            GetBuilder<AddEmployeeDetailsController>(builder: (_) {
              if (_.isLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                  onPressed: () {
                    _.employee == null ? _.saveEmployee() : _.updateEmployee();
                  },
                  child: const Text("Save"));
            }),
            const SizedBox(width: 16)
          ],
        ),
        const SizedBox(height: 10)
      ]),
    );
  }
}

class RoleWidget extends StatelessWidget {
  final String role;
  final Function()? onTap;
  const RoleWidget(
    this.role,
    this.onTap, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(role).marginSymmetric(vertical: 16),
          const Divider(
            thickness: 1,
            indent: 0,
            height: 0,
          )
        ],
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final String hintText, asset;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Function()? onTap;
  const DetailsWidget(this.hintText, this.asset, this.controller,
      {super.key, this.suffixIcon, this.readOnly, this.onTap, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      validator: (validator) ??
          (value) {
            if (value?.isEmpty ?? true) {
              return "This field cannot be empty";
            }
            return null;
          },
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgImage(
              "assets/$asset.svg",
              //  height: 15,
            ),
          ),
          suffixIcon: suffixIcon,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey, width: 1))),
    );
  }
}
