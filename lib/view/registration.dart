import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/get_kyc_model.dart';
import '../res/components/text_editing.dart';
import '../res/components/text_style.dart';
import '../res/status.dart';
import '../view_model/image_controller.dart';
import '../view_model/registration_view_model.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final registerVM = Get.put(RegistrationViewModel());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final imgController = Get.put(ImagePickerController());

  @override
  void initState() {
    super.initState();
    registerVM.getKycDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Registration",
            style: text6().copyWith(fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            switch (registerVM.reqStatus.value) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return const Text("Error");
              case Status.COMPLETED:
                return showRegisterList();
            }
          },
        ),
      ),
    );
  }

  showRegisterList() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50),
          child: ListView.builder(
            itemBuilder: (context, index) {
              registerVM.kycModelList[index].selectedKycFor = "Member";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(registerVM.kycModelList[index].kYCTypeName ?? "",
                      style: text4().copyWith(color: Colors.red)),
                  if (registerVM.kycModelList[index].kycList?.isNotEmpty ??
                      false) ...[
                    kycType(index),
                    const SizedBox(
                      height: 10,
                    ),
                    idOrNumber("ID/Number:", "Enter ID Number", index),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  attachment("Attachment:", "Choose KYC Attachment", index),
                  const SizedBox(
                    height: 10,
                  ),
                  kycFor(index),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
            itemCount: registerVM.kycModelList.length,
            shrinkWrap: true,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: submitButton(),
        )
      ],
    );
  }

  Widget idOrNumber(String typeName, String hintName, int index) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(typeName,
                style: text6()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold))),
        Expanded(
          flex: 3,
          child: EditText(
            controller: registerVM.kycModelList[index].idController,
            hintText: hintName,
            validator: (value) {
              return (value == null || value.isEmpty) ? "Enter the ID" : null;
            },
            onChanged: (value) {
              if (value != null) {
                registerVM.kycModelList[index].idNumber = value;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget attachment(String typeName, String hintName, int index) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(typeName,
                style: text6()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold))),
        Expanded(
          flex: 3,
          child: Obx(
            () => Container(
              height: 155,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: ClipPath(
                child: (registerVM.kycModelList[index].image ?? "").isNotEmpty
                    ? Image.file(
                        File(registerVM.kycModelList[index].image ?? ""),
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                imgController.getImage(index);
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                              )),
                          Text(
                            hintName,
                            style: text4().copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  kycType(int i) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text("KYC Type:",
                style: text6()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold))),
        Expanded(flex: 3, child: kycTypeDropDown(i))
      ],
    );
  }

  kycTypeDropDown(int i) {
    return Obx(
      () => DropdownMenu<String>(
        initialSelection: registerVM.kycModelList[i].selectedKyc,
        expandedInsets: EdgeInsets.zero,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, strokeAlign: 1),
          borderRadius: BorderRadius.circular(10.0),
        )),
        onSelected: (String? value) {
          registerVM.kycModelList[i].selectedKyc = value ?? "";
        },
        dropdownMenuEntries: (registerVM.kycModelList[i].kycList ?? [])
            .map<DropdownMenuEntry<String>>((KycList value) {
          return DropdownMenuEntry<String>(
              value: value.kYCName.toString(), label: value.kYCName.toString());
        }).toList(),
      ),
    );
  }

  kycFor(int index) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text("KYC For:",
                style: text6()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold))),
        Expanded(flex: 3, child: kycForDropDown(index))
      ],
    );
  }

  kycForDropDown(int index) {
    return Obx(
      () => DropdownMenu<String>(
        initialSelection: registerVM.kycModelList[index].selectedKycFor,
        expandedInsets: EdgeInsets.zero,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, strokeAlign: 1),
          borderRadius: BorderRadius.circular(10.0),
        )),
        onSelected: (String? value) {
          registerVM.kycModelList[index].selectedKycFor = value ?? "";
        },
        dropdownMenuEntries: (registerVM.kycForList)
            .map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }

  submitButton() {
    return Obx(
      () => ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              registerVM.submitLoading.value = true;
              registerVM.submitModel();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: registerVM.submitLoading.value
              ? const SizedBox(height: 25,width: 25,
              child: CircularProgressIndicator(color: Colors.white,))
              : Text(
                  "Submit",
                  style: text6().copyWith(color: Colors.white),
                )),
    );
  }
}
