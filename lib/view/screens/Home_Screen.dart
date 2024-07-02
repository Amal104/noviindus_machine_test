import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:noviindus_machine_test/Constants/Size.dart';
import 'package:noviindus_machine_test/Provider/Patient_Provider.dart';
import 'package:noviindus_machine_test/view/screens/Register_Screen.dart';
import 'package:provider/provider.dart';

import '../../Utils/AppColor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<PatientProvider>(context, listen: false).getPatientData();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<PatientProvider>(
          builder: (context, provider, child) {
            return RefreshIndicator(
              onRefresh: () async {
                await provider.refresh();
              },
              child: Column(
                children: [
                  // Search and sort

                  Column(
                    children: [
                      //search

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Search for treatments",
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: AppColor.lightGrey,
                                ),
                                hintStyle: const TextStyle(
                                  color: AppColor.lightGrey,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Text(
                                    "search",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: height(context) * 0.03,
                      ),

                      //sort

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sort by:",
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.lightGrey,
                            ),
                            child: Row(
                              children: [
                                const Text("Date"),
                                SizedBox(
                                  width: width(context) * 0.08,
                                ),
                                const Icon(Icons.arrow_drop_down_outlined),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 2,
                  ),

                  // Patient List

                  Expanded(
                    // height: height(context) * 0.4,
                    child: provider.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: provider.patient.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var patient = provider.patient[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  width: width(context),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGrey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 15, right: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      patient.name,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      patient.address,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: AppColor.green,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                              size: 15,
                                                              color: Colors.red,
                                                            ),
                                                            Text(
                                                              "${patient.dateNdTime!.day.toString()}/${patient.dateNdTime!.month.toString().padLeft(2, '0')}/${patient.dateNdTime!.year.toString().padLeft(2, '0')}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        const Icon(
                                                          Icons.person_2,
                                                          size: 15,
                                                          color: Colors.red,
                                                        ),
                                                        Text(
                                                          patient.user,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Color(0x5C9E9E9E),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 15,
                                          bottom: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "view Booking details",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0x83000000),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                              color: AppColor.green,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Register Now Tab

                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const RegisterScreen(),
                        transition: Transition.cupertino,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
