import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noviindus_machine_test/Constants/Size.dart';
import 'package:noviindus_machine_test/Provider/Patient_Provider.dart';
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
                                Icon(Icons.arrow_drop_down_outlined),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),

                  // Patient List

                  Expanded(
                    // height: height(context) * 0.4,
                    child: ListView.builder(
                      itemCount: 15,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            width: width(context),
                            height: 50,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(5),
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
                    onTap: () {},
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
