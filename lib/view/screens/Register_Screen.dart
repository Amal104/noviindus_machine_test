import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/Constants/Size.dart';
import 'package:noviindus_machine_test/Provider/Register_Provider.dart';
import 'package:provider/provider.dart';

import '../../Utils/AppColor.dart';
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
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
                    hint: "Enter your full name",
                  ),
                  const Text("Whatsapp Number"),
                  RegsterDataTab(
                    controller: provider.nameConroller,
                    hint: "Enter your Whatsapp number",
                  ),
                  const Text("Address"),
                  RegsterDataTab(
                    controller: provider.nameConroller,
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

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
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
                                const Text("Choose Treatment"),
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
                                      value: provider.selectedTreatment,
                                      hint: Text(
                                        "Choose",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                      underline: const SizedBox(),
                                      items: provider.treatment.map((e) {
                                        return DropdownMenuItem(
                                          value: e.name,
                                          child: Text(e.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        provider.onTreatmentChanged(value);
                                      }),
                                ),
                              ],
                            ),
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
