import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_machine_test/Model/Branch_Model.dart';
import 'package:noviindus_machine_test/Model/Treatment_Model.dart';
import 'package:noviindus_machine_test/Services/Branch_List_Services.dart';
import 'package:noviindus_machine_test/Services/Treatment_List_Services.dart';

class RegisterProvider extends ChangeNotifier {
  final nameConroller = TextEditingController();
  final whatsappConroller = TextEditingController();
  final aaddressConroller = TextEditingController();
  final totalamtConroller = TextEditingController();
  final discountamtConroller = TextEditingController();
  final blncamtConroller = TextEditingController();

  List<Branch> branch = [];
  var isLoadingBranch = false;

  List<Treatment> treatment = [];
  var isLoadingTreament = false;

  var locationItems = ['Kochi', 'Kozhikode', 'Bangaluru', 'Chennai', 'Mumbai'];
  String? selectedLocation;
  String? selectedBranch;
  String? selectedTreatment;

  String? selectedDate;

  int? selectedHour;
  int? selectedMinutes;

  int maleCount = 0;
  int femaleCount = 0;

  onLocationChanged(String? value) {
    selectedLocation = value;
    notifyListeners();
  }

  onBranchChanged(String? value) {
    selectedBranch = value;
    notifyListeners();
  }

  onTreatmentChanged(String? value) {
    selectedTreatment = value;
    notifyListeners();
  }

  onHourChanged(int? value) {
    selectedHour = value;
    notifyListeners();
  }

  onMinutesChanged(int? value) {
    selectedMinutes = value;
    notifyListeners();
  }

  getBranchData() async {
    isLoadingBranch = true;
    notifyListeners();

    branch = (await BranchListServices().getBranch());

    isLoadingBranch = false;
    notifyListeners();
  }

  getTreatmentData() async {
    isLoadingTreament = true;
    notifyListeners();

    treatment = (await TreatmentListServices().getTreatment());

    isLoadingTreament = false;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      if (kDebugMode) {
        print(picked);
      }
      selectedDate =
          "${picked.day.toString()}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().padLeft(2, '0')}";
      print(selectedDate);
      notifyListeners();
    }
  }

  final List<int> hours = List<int>.generate(12, (index) => index + 1);
  final List<int> minutes = List<int>.generate(60, (index) => index + 1);

}
