import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noviindus_machine_test/Constants/Size.dart';
import 'package:noviindus_machine_test/Provider/Register_Provider.dart';
import 'package:provider/provider.dart';
import '../../Utils/AppColor.dart';
import '../../Utils/LongButton.dart';
import '../widgets/RegisterDataTab.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<RegisterProvider>(context, listen: false).getBranchData();
        Provider.of<RegisterProvider>(context, listen: false)
            .getTreatmentData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<RegisterProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name"),
                  RegsterDataTab(
                    controller: provider.nameConroller,
                    type: TextInputType.name,
                    hint: "Enter your full name",
                  ),
                  const Text("Whatsapp Number"),
                  RegsterDataTab(
                    controller: provider.whatsappConroller,
                    type: TextInputType.phone,
                    hint: "Enter your Whatsapp number",
                  ),
                  const Text("Address"),
                  RegsterDataTab(
                    controller: provider.aaddressConroller,
                    type: TextInputType.streetAddress,
                    hint: "Enter your full address",
                  ),

                  //Location

                  const Text("Location"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: width(context),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButton(
                        value: provider.selectedLocation,
                        hint: Text(
                          "Choose your location",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        underline: const SizedBox(),
                        items: provider.locationItems.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) => provider.onLocationChanged(value),
                      ),
                    ),
                  ),

                  // Branch

                  const Text("Branch"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width(context),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: AppColor.lightGrey,
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButton(
                      value: provider.selectedBranch,
                      hint: Text(
                        "Select the branch",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[400],
                        ),
                      ),
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 175),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      underline: const SizedBox(),
                      items: provider.branch.map((e) {
                        return DropdownMenuItem(
                          value: e.name,
                          child: Text(e.name),
                        );
                      }).toList(),
                      onChanged: (value) => provider.onBranchChanged(value),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Treatments

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.treatmetntsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}.",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      provider.limitWords(
                                          provider.treatmetntsList[index]
                                              .treatmentName
                                              .toString(),
                                          2),
                                      style: const TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 150,
                                    ),
                                    Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red.shade300,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Male",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.green,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            provider.treatmetntsList[index]
                                                .maleCount
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: AppColor.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Female",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.green,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            provider.treatmetntsList[index]
                                                .femaleCount
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: AppColor.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: AppColor.green,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Container(
                                width: width(context),
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Choose Treatment",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppColor.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: DropdownButton(
                                          value: provider.selectedTreatment,
                                          hint: Text(
                                            "Choose prefered treatment",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                          icon: const SizedBox(),
                                          underline: const SizedBox(),
                                          items: provider.treatment.map((e) {
                                            return DropdownMenuItem(
                                              value: e.name,
                                              child: Text(e.name),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                provider.selectedTreatment =
                                                    value;
                                              },
                                            );
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Add Patients",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text("Male"),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                setState(
                                                  () {
                                                    if (provider.maleCount >
                                                        0) {
                                                      setState(() {
                                                        provider.maleCount--;
                                                      });
                                                    }
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColor.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(provider.maleCount
                                                      .toString()),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                setState(
                                                  () {
                                                    provider.maleCount++;
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColor.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text("Female"),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                setState(
                                                  () {
                                                    if (provider.femaleCount >
                                                        0) {
                                                      setState(() {
                                                        provider.femaleCount--;
                                                      });
                                                    }
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColor.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(provider
                                                      .femaleCount
                                                      .toString()),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                setState(
                                                  () {
                                                    provider.femaleCount++;
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColor.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    LongButton(
                                      title: "Save",
                                      function: () {
                                        provider.addTreatmentListData();
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green.shade200,
                      ),
                      child: const Center(
                        child: Text("+ Add treatments"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Total Amount"),
                  RegsterDataTab(
                    controller: provider.totalamtConroller,
                    type: TextInputType.number,
                    hint: "",
                  ),
                  const Text("Discount Amount"),
                  RegsterDataTab(
                    controller: provider.discountamtConroller,
                    type: TextInputType.streetAddress,
                    hint: "",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Cash',
                            groupValue: provider.selectedPaymentMethod,
                            onChanged: (String? value) {
                              provider.onPaymentChanged(value);
                            },
                          ),
                          const Text(
                            'Cash',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Card',
                            groupValue: provider.selectedPaymentMethod,
                            onChanged: (String? value) {
                              provider.onPaymentChanged(value);
                            },
                          ),
                          const Text(
                            'Card',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'UPI',
                            groupValue: provider.selectedPaymentMethod,
                            onChanged: (String? value) {
                              provider.onPaymentChanged(value);
                            },
                          ),
                          const Text(
                            'UPI',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text("Advance Amount"),
                  RegsterDataTab(
                    controller: provider.advcamtConroller,
                    type: TextInputType.number,
                    hint: "",
                  ),
                  const Text("Balance Amount"),
                  RegsterDataTab(
                    controller: provider.blncamtConroller,
                    type: TextInputType.number,
                    hint: "",
                  ),
                  const Text("Treatment Date"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        provider.selectDate(context);
                      },
                      child: Container(
                        width: width(context),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(provider.selectedDate ?? ""),
                            Icon(
                              Icons.calendar_month,
                              color: AppColor.green,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text("Treatment Time"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.lightGrey,
                          ),
                          child: DropdownButton<int>(
                            value: provider.selectedHour,
                            hint: const Text('Hour'),
                            underline: const SizedBox.shrink(),
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 80),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            items: provider.hours.map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              provider.onHourChanged(newValue);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.lightGrey,
                          ),
                          child: DropdownButton<int>(
                            value: provider.selectedMinutes,
                            hint: const Text('Minutes'),
                            underline: const SizedBox.shrink(),
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 60),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            items: provider.minutes.map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              provider.onMinutesChanged(newValue);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LongButton(
                    title: "Save",
                    function: () {
                      HapticFeedback.lightImpact();
                      provider.sendPatientData(context);
                      provider.pdf(context);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
