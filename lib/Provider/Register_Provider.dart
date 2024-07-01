import 'package:flutter/material.dart';
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
}
